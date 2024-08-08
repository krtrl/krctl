import cligen
import std/httpclient
import commands/system
import commands/server
import commands/service

proc configure(url: string, port = 5000) =
    ## Configure krctl.

proc container() =
    ## Container management
    echo "WIP"

proc checkUp() =
    ## krtrl checkUp management
    echo "WIP"

proc runList() =
    ## krtrl runList management
    echo "WIP"

dispatchMultiGen(
    [ "sys" ], [ system.info, mergeNames = @[ "krctl", "system" ]],
    [ "sys" ], [ system.run, mergeNames = @[ "krctl", "system" ]]
)

dispatchMultiGen(
    [ "srver" ], [ server.create, mergeNames = @[ "krctl", "server" ]],
    [ "srver" ], [ server.delete, mergeNames = @[ "krctl", "server" ]]
)

dispatchMultiGen(
    [ "srvice" ], [ servinfo, mergeNames = @[ "krctl", "service" ], cmdName = "status"]
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
    [
        srvice,
        doc = "Service management",
        usage = "$doc\n",
        stopWords = @["status"],
        cmdName = "service"
    ],
    [container], 
    [checkUp],
    [runList]
)
