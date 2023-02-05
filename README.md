# AATexDiff
zh：更方便的使用latexdiff，推荐和右键菜单一起食用

**作用：将当前tex（revised）与另一个tex（原始）进行比对，然后打开tex或编译并打开pdf**

参数：`args[0]:revised path, args[1]:"OpenTex"/"CompileTexAndOpenPdf"`

调用方法：

1.命令行：`powershell AASTexDiff.ps1 TexPath OpenTex/CompileTexAndOpenPdf`

2.右键菜单食用：选中修订后的tex文件，右键菜单`Diff`中选中`PDFCompiled`或`TexDiffed`即可

过程：选中要比对的原始tex文件即可，然后就**Happy，Lucky，Smile**的wait~

---

en：More Convenient Way to use latexdiff. Recommend to use with Right Click meau.

**Function:Compared with original tex file and use the default way in ur computer to open the diffed tex file or open the pdf one with compiled the diffed tex file**

script args:`args[0]:revised path, args[1]:"OpenTex"/"CompileTexAndOpenPdf"`

Instruction:

1.command:`powershell AASTexDiff.ps1 TexPath OpenTex/CompileTexAndOpenPdf`

2.Enjoy with Right click context menu：choose the revised tex file ,then right click, choose `PDFCompiled` or `TexDiffed`

Process:choose the original tex files, then wait with **Happy, Lucky, Smile**~
