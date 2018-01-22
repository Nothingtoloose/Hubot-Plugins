#Einführung
Hier sind einige Plugins, die ich selbst erstellt oder angepasst habe.

Die Plugins wurden so angepasst, damit sie per Mattermost genutzt werden können. Einige Plugins funktionieren mit jedem Chat. Als Adapter für Hubot kommt Hubot Matteruser (https://github.com/loafoe/hubot-matteruser) zum Einsatz.

#Übersicht der Plugins:
*ankuendigung.js
Dient zum Posten einer Nachricht in verschiedenen Kanälen
*keineBefehle-Direkt.coffee
Verbietet die Ausführung von Hubot Befehlen im direkten Chat mit Hubot (nur mit Hubot Matteruser nutzbar)
*keineBefehle-Gruppe.coffee
Verbietet die Ausführung von Hubot Befehlen im GruppenChat mit Hubot (nur mit Hubot Matteruser nutzbar)
*rollen.coffee
Dient zum Verwalten von Hubot Rechten. Die Rechte können pro User vergeben werden. Der Benutzernname muss mit dem Chatnamen übereinstimmen. Benötigt rolleninfos.coffee sowie Hubot-Approval (https://github.com/Nothingtoloose/hubot-approval).
*rolleninfos.coffee
Dient zum Auslesen der Benutzerrechte. Benötigt rollen.coffee sowie Hubot-Approval (https://github.com/Nothingtoloose/hubot-approval).
*unbekannteNachricht.js
Hubot schreibt in den Chat, wenn er einen Befehl nicht erkannt hat. Dieses Plugin ist auf den Namen "Hubot" / "@Hubot" angepasst. Wenn der Bot einen anderen Namen hat, so muss dieses Plugin angepasst werden.
