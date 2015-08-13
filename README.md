# FolderHelper
Pour aider à la gestion des dossiers En cours/VO
Par Paneb pour la Confrérie



====================
Que fait le script ?
====================

Le script est pensé pour une utilisation dans le cadre d'un dossier de travaux de traductions type :
 [N'importe quel chemin]\Mods\VO
 [N'importe quel chemin]\Mods\VF
 [N'importe quel chemin]\Mods\En cours de traduction
 A noter que les noms sont données à titre d'exemple, dans tous les cas le script s'exécutera même si vos dossiers ne se nomment pas ainsi.
 En partant du dossier où il est exécuté, il créera un dossier "En cours de traduction" à coté du dossier où il est si il n'existe pas déjà (à exécuter dans VO).
 Ensuite il copiera les dossiers ajoutés depuis la dernière utilisation dans VO dans "En cours de traduction", en créant un dossier Data si il n'existe pas déjà, de même qu'un dossiers "Screens"
 Si aucun nouveau dossier n'est présent, rien ne se passe lors de l'appui sur F1.
 Il n'est pas obligatoire de l'exécuter à chaque nouveau dossier. Vous pouvez télécharger plusieurs mods et l'activer par la suite, il copiera l'ensemble des nouveaux dossiers depuis la dernière mise à jour de modList.txt (donc depuis le F1 ou F3 de son dernier lancement)
 On peut éventuellement imaginer une évolution de ce script à placer dans Mods, et qui ferai passer les mods de dossier en dossier selon un fichier .txt contenant une ligne goTrad, goVF, goTest ou autre.
 Mais j'ai pour l'instant pas tellement entamé mes traductions en cours, donc pas pour tout de suite ces subtilités :p.
 Idem, on peut aussi envisager de lancer automatiquement l'ESP dans votre gestionnaire de traduction préféré (facile depuis que j'ai appris qu'EET accepté avec joie les paramètres :D)
 A noter, screen et screens sont pris en compte. Et insensible à la casse ('DATA, SCReeNS, SCREEN, DATA, etc)

=============
Utilisation :
=============
Placez le script dans le dossier où se trouve vos archives VO (par exemple C:\La Confrérie\Mods\VO)
Exécutez le script avec AutoHotKey, ou bien lancez la version exécutable
Plusieurs choix sont possibles :
Option 1 : vous n'avez pas d'arborescence de ce type en place
	Lors du premier lancement, soit vous voulez copiez tous les mods présents dans C:\La Confrérie\Mods\En traduction, en ré-agencant leur arborescence.
	Il suffit de faire un appui sur F1 et tout les dossiers seront copiées. Par ailleurs, un fichier modList.txt sera créé pour les lancements futurs.
	C'est dans ce dernier que sont stockés les mods dont la copie a été effectuée.
Option 2 : vous avez déjà une arborescence de ce type en place
	Il vous suffit au premier lancement d'appuyer sur F3. Le fichier modList.txt sera créé et contiendra la liste des dossiers de VO
	Il suffira par la suite d'appuyer sur F1 a chaque ajout de dossier pour copier le nouveau et mettre à jour la liste
	
==============
Installation
==============
Suivre les instructions ci-dessus si .exe choisi (seulement à placer dans le dossier des mods en VO)
Sinon télécharger AutoHotKey et run le script manuellement si .ahk (http://www.autohotkey.org/)



