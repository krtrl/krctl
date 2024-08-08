import std/json
import std/terminal
import std/httpclient

proc printFancy(itemType: string, value: string) =
    ## Wrapper of styledWriteLine.
    stdout.styledWriteLine(fgBlue, itemType, fgWhite, ": ", value)

proc servinfo*(service: string) =
    ## Get service information.
    var client = newHttpClient()
    var res: JsonNode
    try:
        res = parseJson(client.getContent("http://localhost:5000/api/v1/services/"&service&"/info"))
    finally:
        client.close()

    echo $res
