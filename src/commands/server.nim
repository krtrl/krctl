import std/parsecfg

proc saveToConfig(name, url, group: string) =
    echo "Saving server "&name&" to config file..."

proc deleteFromConfig(name, group: string) =
    echo "Deleting server "&name&" from config file..."

proc deleteKrtrld(name, group: string) =
    echo "Deleting krtrld from server..."

proc installKrtrld(name, group: string) =
    echo "Installing krtrld to server..."

proc create*(name: string, url = "", install = false, group = "") =
    ## Create and add a new server to the list of servers
    if install:
        echo "Installing krtrld to the server..."
        installKrtrld(name, group)
        saveToConfig(name, url, group)
    elif url != "":
        echo "Adding server: "&name
        saveToConfig(name, url, group)
    else:
        echo "No URL provided for server: "&name
        quit(1)

proc delete*(name: string, group: string, deleteKrtrld = true) =
    ## Delete a server from the list of servers
    echo "Deleting server "&name&" from config file..."
    deleteFromConfig(name, group)
    if deleteKrtrld:
        echo "Deleting krtrld from server..."
        deleteKrtrld(name, group)
    else:
        echo "Not deleting krtrld from server"
