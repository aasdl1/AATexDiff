# AATexDiff
zh：更方便的使用latexdiff，推荐和右键菜单一起食用

**作用：将当前tex（revised）与另一个tex（原始）进行比对，然后打开tex或编译并打开pdf**

参数：`args[0]:revised path, args[1]:"OpenTex"/"CompileTexAndOpenPdf"`

调用方法：

1.命令行：`powershell AASTexDiff.ps1 TexPath OpenTex/CompileTexAndOpenPdf`

2.右键菜单食用：选中修订后的tex文件，右键菜单`Diff`中选中`PDFCompiled`或`TexDiffed`即可

过程：选中要比对的原始tex文件即可，然后就**Happy，Lucky，Smile**的wait~

## 如何添加右键菜单

具体的参考网上的教程，[这篇写的不错](https://blog.csdn.net/yang382197207/article/details/80079052)

此处给出的reg文件中，与`.tex`绑定的项是自定义的新项`TexFiles`，如果你也是`TexFiles`那么就可以直接导入，但是在其中需要将以下内容**自行修改**
- **脚本路径**，此处是`C:\\Users\\aasdl1\\Desktop\\Code\\AAScripts\\AASTexDiff.ps1`
- **打开tex的默认程序**，此处是利用`texStudio`打开的，`E:\\Software\\texstudio-4.3.1-win-portable-qt6\\texstudio.exe`
---

en：More Convenient Way to use latexdiff. Recommend to use with Right Click menu.

**Function:Compared with original tex file and use the default way in ur computer to open the diffed tex file or open the pdf one with compiled the diffed tex file**

script args:`args[0]:revised path, args[1]:"OpenTex"/"CompileTexAndOpenPdf"`

Instruction:

1.command:`powershell AASTexDiff.ps1 TexPath OpenTex/CompileTexAndOpenPdf`

2.Enjoy with Right click context menu：choose the revised tex file ,then right click, choose `PDFCompiled` or `TexDiffed`

Process:choose the original tex files, then wait with **Happy, Lucky, Smile**~

## How to add right click context menu

Please find an arbitrary technical blog to study, You must be **caution** if you don't familiar with Regedit operation, backup before anyoperation, btw.[This blog is fine](https://blog.csdn.net/yang382197207/article/details/80079052)

In my reg file in resposity, `TexFiles` bind with the `.tex`, you can import the reg directly if the same to you after **modify** the following item 
- **Script path**，here is `C:\\Users\\aasdl1\\Desktop\\Code\\AAScripts\\AASTexDiff.ps1`
- **Default program to open tex file**, I use the `texStudio`, so here is it's path:`E:\\Software\\texstudio-4.3.1-win-portable-qt6\\texstudio.exe`
