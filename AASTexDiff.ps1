# ===== ����ǰtex��revised������һ��tex��ԭʼ�����бȶԣ�Ȼ����벢��pdf����ѡ��==== #
# ������args[0]:revised path, args[1]:"OpenTex"/"CompileTexAndOpenPdf"
# ���÷�����
# 1.�����У�powershell AASTexDiff.ps1 TexPath OpenTex/CompileTexAndOpenPdf
# 2.�Ҽ��˵�ʳ�ã�ѡ���޶����tex�ļ����Ҽ��˵�Diff��ѡ��PDFCompiled��TexDiffed����
# ���̣�ѡ��Ҫ�ȶԵ�ԭʼtex�ļ����ɣ�Ȼ���Happy��Lucky��Smile��wait~

# ��д���� ��Ȼû��ʶ��
function compileTexAndOpenPdf($texPath) {
    # === ����tex�ļ���pdflatex������pdf ===
    # ����texPath������·������û�з���
    # ���̣�Ϊpdflatexһ�ߣ�Bitexһ�ߣ�pdflatex����
    echo "textPath:"$texPath

    # �ж�texPath�Ƿ����
    if ($texPath -eq "") {
        echo "compileTexAndOpenPdf without tex path"
        return
    }
    
    $texName = (Get-Item $texPath).BaseName
    $texDir = (Get-Item $texPath).DirectoryName

    $beforeWd = $pwd

    cd $texDir

    # ��������
    pdflatex.exe -synctex=1 -interaction=nonstopmode $texName".tex"
    bibtex.exe $texName
    pdflatex.exe -synctex=1 -interaction=nonstopmode $texName".tex"
    pdflatex.exe -synctex=1 -interaction=nonstopmode $texName".tex"

    # Open
    start $texName".pdf"

    # ����ԭʼ·��
    cd $beforeWd
}


# ���Ʊ�־
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

# diff�ļ��ŵ�revised�����򿪱��ű���λ��
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

# ���ļ�����ѡ���ļ�
Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.InitialDirectory = $revisedFileForePath
$f.Filter = "Latex Files (*.tex)|*.tex|All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $false
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }

$orgFilePath = $f.FileName
# ��ԭʼ·��Ϊ�����˳�
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
    # ����һ������ѡ���Ƿ񸲸�
    $p = New-Object -ComObject WScript.Shell
    $ifreplace = $p.popup("Diffed File Existed, Replace?",0,"Diffed File Existed",1 + 64)
    if ($ifreplace -ne 1) {
        # ignore
        # �൱�ڲ������κδ���
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

# ����cmd����diff��powershell����latexdiff���б�������
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