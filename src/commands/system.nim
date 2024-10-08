import std/json
import std/terminal
import std/httpclient

proc printFancy(itemType: string, value: string) =
    ## Wrapper of styledWriteLine.
    stdout.styledWriteLine(fgBlue, itemType, fgWhite, ": ", value)

proc info*() =
    ## Get system information.
    var client = newHttpClient()
    var res: JsonNode
    try:
        res = parseJson(client.getContent("http://localhost:5000/api/v1/system/info"))
    finally:
        client.close()

    printFancy("Hostname", res["system"]["hostname"].getStr())
    printFancy("Operating System (Pretty)", res["system"]["osPrettyName"].getStr())
    printFancy("Operating System", res["system"]["os"].getStr())
    printFancy("Package Managers", $res["system"]["packageManagers"])
    printFancy("Init System", res["system"]["initSystem"].getStr())
    printFancy("Platform", res["system"]["platform"].getStr())
    printFancy("CPU Architecture", res["system"]["arch"].getStr())
    printFancy("CPU Count", $res["system"]["cpus"].getInt())
    printFancy("Memory", res["system"]["memory"].getStr())

    printFancy("Disks", "TBD")
    

proc run*(command: string, daemon = false) =
   ## Run a command.
   var client = newHttpClient()
   var res: JsonNode
   let body = %*{
       "cmd": command,
       "daemon": daemon
   }
   
   try:
      res = parseJson(client.postContent("http://localhost:5000/api/v1/system/run", $body))
   finally:
      client.close()

   if daemon:
      printFancy("Command",  res["command"].getStr())
      printFancy("Process ID", $res["PID"])
   else:
      echo res["output"].getStr()
      quit(res["exitCode"].getInt())
