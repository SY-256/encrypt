'====================================
' ps1�̋N���p�X�N���v�g
'====================================
Option Explicit

'FSO�I�u�W�F�N�g�AShell�I�u�W�F�N�g
Dim objFSO
Dim objWshShell

'VBS�p�X�AVBS�i�[�t�H���_�APS1�p�X
Dim strVBSPath
Dim strVBSFolder
Dim strPS1Path
Dim runPS1Name

runPS1Name = InputBox("���s����PS1���g���q�t���œ��͂��Ă��������B")

'�I�u�W�F�N�g�Q��
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objWshShell = WScript.CreateObject("WScript.Shell")

'VBS�p�X�AVBS�i�[�t�H���_�APS1�p�X
strVBSPath = Wscript.ScriptFullName
strVBSFolder = objFSO.GetFile(StrVBSPath).ParentFolder
strPS1Path = strVBSFolder & "\" & runPS1Name

'PS1�N���I�v�V����
Const OPT = "Powershell -ExecutionPolicy Unrestricted -Windowstyle Hidden -NoProfile -File "

'PS1�N��
objWshShell.Run OPT & strPS1Path,0,True

'�I�u�W�F�N�g���
Set objFSO = Nothing
Set objWshShell = Nothing

'�I��
Wscript.Quit