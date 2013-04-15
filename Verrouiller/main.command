#!/usr/bin/env sh

#  main.command
#  Verrouiller

#  Created by Sylvain on 13/04/2013.
#  Copyright (c) 2013 Automatisez sous Mac. All rights reserved.


# Active le mode 'trace' de Bash pour suivre le déroulement
set -xv

# Utilise la console pour les messages d'erreurs
exec 2>>/dev/console

# Affiche les variables d'environnement de notre script
#   Permet de vérifier les liaisons
#
#   'actif' est une variable définie dans les options de l'action
printenv 1>&2

# On lit chaque ligne en entrée, chaque ligne est un chemin de fichier/dossier
while read leFichier
do
    # Par défaut, déverrouille le fichier
    flag="nouchange"

    # 0 pour faux, 1 pour vrai
    if test "1" == "$actif"
    then
        # Verrouillage du fichier si option à vrai
        flag="uchange"
    fi

    # Si le chemin correspond à un fichier ou dossier
    if test -a "$leFichier"
    then
        # Applique la commande avec l'option correspondant à l'option
        chflags $flag "$leFichier"
    else
        # Ou on affiche une erreur si le chemin ne correspond à rien
        echo "Alerte: le fichier \"$leFichier\" n'existe pas." 1>&2 
    fi
done