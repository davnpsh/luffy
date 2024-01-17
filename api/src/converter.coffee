import { log } from "./logger.coffee"
import ffbinaries from "ffbinaries"
import fs from "fs"
import { exec } from "child_process"

# Bin folder
binFolder = "./bin"
binExecutable = "./bin/ffmpeg"

# Relative path to the root folder
path = "./public"
virtualPath = "/api/video"

# Video stats
oldFormat = ".mkv"
newFormat = ".mp4"
subsFormat = ".srt"

downloadBinary = ->
  new Promise (resolve, reject) ->
    log "ffmpeg", "Checking ffmpeg binary existence."

    fs.access binExecutable, fs.constants.F_OK, (err) ->
      if err
        log "ffmpeg", "Binary not found."

        # Create folder if it doesnt exist
        if !fs.existsSync binFolder
          fs.mkdirSync binFolder

        # Download binary
        log "ffmpeg", "Downloading binary from internet."
        ffbinaries.downloadBinaries(
          ["ffmpeg"]
        ,
          platform: "linux-64", quiet: true, destination: binFolder
        ,
          ->
            log "ffmpeg", "ffmpeg is ready."
            resolve()
        )
        return
      else
        log "ffmpeg", "Binary found."
        resolve()

convertToMP4 = (fileName) ->
  new Promise (resolve, reject) ->
    newFileName = "#{fileName.replace oldFormat, ""}#{newFormat}"

    inputFile = "#{path}/#{fileName}"
    outputFile = "#{path}/#{newFileName}"

    command = "#{binExecutable} -i '#{inputFile}' -map 0 -c copy -c:a aac '#{outputFile}'"

    log(
      "ffmpeg"
      "Attemping to convert from video source from #{oldFormat} to #{newFormat}."
    )
    exec command, (err, stdout, stderr) ->
      if err
        log "ffmpeg error", err.message
        reject()

      log "ffmpeg", "Conversion done."
      resolve newFileName

extractSubtitles = (fileName) ->
  new Promise (resolve, reject) ->
    subsFile = "#{fileName.replace oldFormat, ""}#{subsFormat}"

    inputFile = "#{path}/#{fileName}"
    outputFile = "#{path}/#{subsFile}"

    command = "#{binExecutable} -i '#{inputFile}' -map 0:s:0 '#{outputFile}'"

    log "ffmpeg", "Attemping to extract subtitles from media source."
    exec command, (err, stdout, stderr) ->
      if err
        log "ffmpeg error", err.message
        reject()

      log "ffmpeg", "Extraction done."
      resolve subsFile

export convert = (fileName) ->
  try
    # Get ffmpeg
    await downloadBinary()

    # Uncomment this block to ensure compatibility with all web browsers. It migh be very slow, tho
    ###
    log "answer", "Retrieved subtitles from media source."
    videoFile = await convertToMP4 fileName
    videoFilePath = "#{virtualPath}/#{videoFile}"
    ###
    # Comment the following line if you uncommented the previous block
    videoFilePath = "#{virtualPath}/#{fileName}"

    subsFile = await extractSubtitles fileName
    subsFilePath = "#{virtualPath}/#{subsFile}"
    log "answer", "Retrieved subtitles from media source."

    return videoFilePath: videoFilePath, subsFilePath: subsFilePath
  catch
    log "error", "Error trying to convert media source."
