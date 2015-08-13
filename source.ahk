;Que fait le script ?
;Le script est pensé pour une utilisation dans le cadre d'un dossier de travaux de traductions type :
; [N'importe quel chemin]\Mods\VO
; [N'importe quel chemin]\Mods\VF
; [N'importe quel chemin]\Mods\En cours de traduction
; A noter que les noms sont données à titre d'exemple, dans tous les cas le script s'exécutera même si vos dossiers ne se nomment pas ainsi.
; En partant du dossier où il est exécuté, il créera un dossier "En cours de traduction" à coté du dossier où il est si il n'existe pas déjà (à exécuter dans VO).
; Ensuite il copiera les dossiers ajoutés depuis la dernière utilisation dans VO dans "En cours de traduction", en créant un dossier Data si il n'existe pas déjà, de même qu'un dossiers "Screens"
; Si aucun nouveau dossier n'est présent, rien ne se passe lors de l'appui sur F1.
; Il n'est pas obligatoire de l'exécuter à chaque nouveau dossier. Vous pouvez télécharger plusieurs mods et l'activer par la suite, il copiera l'ensemble des nouveaux dossiers depuis la dernière mise à jour de modList.txt (donc depuis le F1 ou F3 de son dernier lancement)
; On peut éventuellement imaginer une évolution de ce script à placer dans Mods, et qui ferai passer les mods de dossier en dossier selon un fichier .txt contenant une ligne goTrad, goVF, goTest ou autre.
; Mais j'ai pour l'instant pas tellement entamé mes traductions en cours, donc pas pour tout de suite ces subtilités :p.
; Idem, on peut aussi envisager de lancer automatiquement l'ESP dans votre gestionnaire de traduction préféré (facile depuis que j'ai appris qu'EET accepté avec joie les paramètres :D)
; A noter, screen et screens sont pris en compte. Et insensible à la casse ('DATA, SCReeNS, SCREEN, DATA, etc)

;Utilisation :
;Placez le script dans le dossier où se trouve vos archives VO (par exemple C:\La Confrérie\Mods\VO)
;Exécutez le script avec AutoHotKey, ou bien lancez la version exécutable
;Plusieurs choix sont possibles :
;Option 1 : vous n'avez pas d'arborescence de ce type en place
	;Lors du premier lancement, soit vous voulez copiez tous les mods présents dans C:\La Confrérie\Mods\En traduction, en ré-agencant leur arborescence.
	;Il suffit de faire un appui sur F1 et tout les dossiers seront copiées. Par ailleurs, un fichier modList.txt sera créé pour les lancements futurs.
	;C'est dans ce dernier que sont stockés les mods dont la copie a été effectuée.
;Option 2 : vous avez déjà une arborescence de ce type en place
	;Il vous suffit au premier lancement d'appuyer sur F3. Le fichier modList.txt sera créé et contiendra la liste des dossiers de VO
	;Il suffira par la suite d'appuyer sur F1 a chaque ajout de dossier pour copier le nouveau et mettre à jour la liste




;CODE SOURCE A MODIFIER SELON VOS DESIRS (mais je n'endosse pas la responsabilité de ce qui peut s'ensuivre ^^)
#NoEnv
SendMode Input 
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
;Variables globales pour les modifier de partout (les codeurs c'est pas bien je sais)
myListDefault := Object()
myNewList := Object()

;Constantes utilisés au fil de la création des dossiers
enTrad = En cours de traduction
folder1 = Screens
folder12 = Screen
folder2 = Data


Loop, Files, %A_WorkingDir%\*, D
	myListDefault.Insert(A_LoopFileName)
Loop, Files, %A_WorkingDir%\*, D
	myNewList.Insert(A_LoopFileName)


checkUpdate(){
myNewListTemp := Object()
	Loop, Files, %A_WorkingDir%\*, D
		myNewListTemp.Insert(A_LoopFileName)

return myNewListTemp
}


;Utilisée pour activer la détection et la copie de nouveau dossier présent depuis le dernier lancement
F1::
	myListDefault :=
	IfExist, modList.txt
	Loop
	{
 		FileReadLine, folder, %A_WorkingDir%\modList.txt, %A_Index%
 		if ErrorLevel
  		break
		myListDefault.Insert(folder)
	}
	IfNotExist, modList.txt
	Loop, Files, %A_WorkingDir%\*, D
		myListDefault.Insert(A_LoopFileName)
	myNewList := checkUpdate()
	Loop % myNewList.MaxIndex()
		{
			folderTest := myNewList[A_Index]
			isNew = 0
			for index, element in myListDefault
			{
 				if(element == folderTest){
					isNew++
				}
			}
			tmp := checkIfCopy(folderTest)
			if(isNew = 0) and (folderTest) and ( tmp = 100){
				MsgBox % "Nouveau dossier de mod :  " . folderTest . ". Copie dans en traduction et création dossier Screens, Data si non existants."
				myListDefault.Insert(folderTest)
				FileAppend, %folderTest%`n, modList.txt
				fullPath = %A_WorkingDir%\%folderTest%
				addScreen = 1
				addData = 1
				StringLower, folder2L, folder2, T
				StringLower, folder12L, folder12, T
				StringLower, folder1L, folder1, T
				FileCopyDir, %fullPath%, %A_WorkingDir%\..\%enTrad%\%folderTest%\%folderTest%, 0
				myModList := Object()
				Loop, Files, %A_WorkingDir%\%folderTest%\*, D
					myModList.Insert(A_LoopFileName)
				Loop % myModList.MaxIndex()
				{
					folderTestMod := myModList[A_Index]
					StringLower, folderTestModL, folderTestMod, T
					if(folderTestModL==folder1L) or (folderTestModL == folder12L)
						addScreen = 0
					if(folderTestModL == folder2L)
						addData = 0
				}
				if(addScreen = 1)
					FileCreateDir, %A_WorkingDir%\..\%enTrad%\%folderTest%\%folder1%
				if(addData =  1)
					FileMoveDir, %A_WorkingDir%\..\%enTrad%\%folderTest%\%folderTest%, %A_WorkingDir%\..\%enTrad%\%folderTest%\Data, R
			}				
		}	
	
return



;Eté Utilisée à fin de test
;F2::
;myNewList := checkUpdate()
;Loop % myNewList.MaxIndex()
;		{
;			folderTest := myNewList[A_Index]
;			MsgBox, %folderTest%
;		}
;return

;Utilisée pour créer un fichier avec les mods déjà présents dans le dossier
F3::
Loop, Files, %A_WorkingDir%\*, D
	myListDefault.Insert(A_LoopFileName)
Loop % myListDefault.MaxIndex()
	{
		folderTest := myListDefault[A_Index]
		isNew = 1
		Loop
		{
    			FileReadLine, folder, %A_WorkingDir%\modList.txt, %A_Index%
    			if ErrorLevel
        			break
			if(folder == folderTest)
			{
				isNew = 0
				break		
			}
		}
		if(isNew = 1)
			FileAppend, %folderTest%`n, modList.txt
		}
return

;Vérifie si le dossier est déjà présent dans la liste des dossiers copiés
checkIfCopy(folder){
	isNew = 1
	Loop
	{
 		FileReadLine, folderTest, %A_WorkingDir%\modList.txt, %A_Index%
 		if ErrorLevel
  			break
		if(folder == folderTest)
		{
			isNew = 0
			break		
		}
	}
	if(isNew = 1)
		;FileAppend, %folderTest%`n, modList.txt
		;MsgBox, Le dossier %folder% va être copié et agencé
		return 100
	else{
		
		;MsgBox, Un dossier a déjà été copié avec ce nom : %folder%... annulation.
		return 0
	}
}
