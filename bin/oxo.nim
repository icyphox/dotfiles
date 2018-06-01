#!/usr/bin/env nimcr

import httpclient
import os
import strformat

var client = newHttpClient()
var data = newMultipartData()

try:
  var file = paramStr(1)
  data.addFiles({"file": fmt"{file}"})
  let url = "http://0x0.st"
  echo client.postContent(url, multipart=data)
except IndexError:
  echo "no file specified :v"
  quit(1)
