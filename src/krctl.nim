import cligen
import std/httpclient
import commands/system
import commands/server

proc configure(url: string, port = 5000) =
    ## Configure krctl.

proc container() =
    ## Container management
    echo "WIP"

proc service() =
    ## Service management
    echo "WIP"

proc checkUp() =
    ## krtrl checkUp management
    echo "WIP"

proc runList() =
    ## krtrl runList management
    echo "WIP"

dispatchMultiGen(
    [ "sys" ], [ info, mergeNames = @[ "krctl", "system" ]],
    [ "sys" ], [ run, mergeNames = @[ "krctl", "system" ]]
)

dispatchMultiGen(
    [ "srver" ], [ server.create, mergeNames = @[ "krctl", "server" ]],
    [ "srver" ], [ server.delete, mergeNames = @[ "krctl", "server" ]]
)

dispatchMulti(
    [
        sys,
        doc = "System management", 
        usage = "$doc\n", 
        stopWords = @["info", "run"],
        cmdName = "system"
    ],
    [
        srver,
        doc = "Server management",
        usage = "$doc\n", 
        stopWords = @["create", "delete"],
        cmdName = "server"
    ],
    [container], 
    [service], 
    [checkUp], 
    [runList]
)
