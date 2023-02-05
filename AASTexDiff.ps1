# ===== 将当前tex（revised）与另一个tex（原始）进行比对，然后编译并打开pdf（可选）==== #
# 参数：args[0]:revised path, args[1]:"OpenTex"/"CompileTexAndOpenPdf"
# 调用方法：
# 1.命令行：powershell AASTexDiff.ps1 TexPath OpenTex/CompileTexAndOpenPdf
# 2.右键菜单食用：选中修订后的tex文件，右键菜单Diff中选中PDFCompiled或TexDiffed即可
# 过程：选中要比对的原始tex文件即可，然后就Happy，Lucky，Smile的wait~

# 先写函数 不然没法识别
function compileTexAndOpenPdf($texPath) {
    # === 构建tex文件（pdflatex）并打开pdf ===
    # 接收texPath（完整路径），没有返回
    # 流程：为pdflatex一边，Bitex一边，pdflatex两遍
    echo "textPath:"$texPath

    # 判断texPath是否存在
    if ($texPath -eq "") {
        echo "compileTexAndOpenPdf without tex path"
        return
    }
    
    $texName = (Get-Item $texPath).BaseName
    $texDir = (Get-Item $texPath).DirectoryName

    $beforeWd = $pwd

    cd $texDir

    # 构建过程
    pdflatex.exe -synctex=1 -interaction=nonstopmode $texName".tex"
    bibtex.exe $texName
    pdflatex.exe -synctex=1 -interaction=nonstopmode $texName".tex"
    pdflatex.exe -synctex=1 -interaction=nonstopmode $texName".tex"

    # Open
    start $texName".pdf"

    # 返回原始路径
    cd $beforeWd
}


# 控制标志
$isCompileTexAndOpenPdf=$False
$isOpenTex=$False

if ($args[1] -eq "OpenTex") {
    $isOpenTex=$True
}
elseif($args[1] -eq "CompileTexAndOpenPdf") {
    $isCompileTexAndOpenPdf=$True
}
else {
    echo "Error:Params Error"
    exit -1
}

# diff文件放到revised，即打开本脚本的位置
$orgFilePath=""
$orgFileName=""
$revisedFilePath=""
$revisedFileName=""
$revisedFileForePath=""
$diffFilePath=""

# set Value
$revisedFilePath=$args[0]
$revisedFileName=(Get-Item $revisedFilePath).BaseName
$revisedFileForePath=(Get-Item $revisedFilePath).DirectoryName

# 从文件框中选择文件
Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.InitialDirectory = $revisedFileForePath
$f.Filter = "Latex Files (*.tex)|*.tex|All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $false
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }

$orgFilePath = $f.FileName
# 若原始路径为空则退出
if ($orgFilePath -eq ""){
    echo "Error:File Path Empty"
    exit -1
}

$orgFileName = (Get-Item $orgFilePath).BaseName


$diffFilePath=$revisedFileForePath+"\"+"diff_"+$orgFileName+"_"+$revisedFileName+".tex"

# echo $diffFilePath
# echo $orgFilePath
# echo $revisedFilePath

if (Test-Path -Path $diffFilePath -PathType Leaf) {
    # existed
    # 创建一个窗口选择是否覆盖
    $p = New-Object -ComObject WScript.Shell
    $ifreplace = $p.popup("Diffed File Existed, Replace?",0,"Diffed File Existed",1 + 64)
    if ($ifreplace -ne 1) {
        # ignore
        # 相当于不进行任何处理
        $pp = New-Object -ComObject WScript.Shell
        $pp.popup("Compare Failed",0,"Failed",0 + 64)
        exit -1
        # echo "ignore"
    }
    else {
        # replace
        # echo "replace"
    }
}

echo "Diffing..."

$p = New-Object -ComObject WScript.Shell
$p.popup("Processing... Please wait a few seconds ;)\n Hello, Lucky, Smile~",1,"Processing",0 + 64)

# 调用cmd进行diff，powershell调用latexdiff会有编码问题
# latexdiff $orgFilePath $revisedFilePath > $diffFilePath
"latexdiff "+$orgFilePath+" "+$revisedFilePath+" > "+$diffFilePath | cmd


if ($isOpenTex){
    echo "Opening the Tex..."
    start $diffFilePath
}
elseif ($isCompileTexAndOpenPdf) {
    echo "Compiling And Opening the PDF..."
    compileTexAndOpenPdf $diffFilePath
}

echo "===== Script Done ;) ====="
echo "Bug Reported to aasdl1@nwafu.edu.cn ^0^"