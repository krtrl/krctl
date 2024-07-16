import cligen
import std/httpclient
import commands/system

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

dispatchMultiGen([ "sys" ], [ info, mergeNames = @[ "krctl", "system" ]])

dispatchMulti(
    [
        sys,
        doc = "System management", 
        usage = "$doc\n", 
        stopWords = @["info"],
        cmdName = "system"
    ],
    [container], 
    [service], 
    [checkUp], 
    [runList]
)
