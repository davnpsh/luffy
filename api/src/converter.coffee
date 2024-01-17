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
newFormat = ".webm"
subsFormat = ".vtt"

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

convertVideo = (fileName) ->
  # Create folder if it doesnt exist
  if !fs.existsSync path
    fs.mkdirSync path

  new Promise (resolve, reject) ->
    newFileName = "#{fileName.replace oldFormat, ""}#{newFormat}"

    inputFile = "#{path}/#{fileName}"
    outputFile = "#{path}/#{newFileName}"

    # For webm (with hardsub)
    command = "#{binExecutable} -i '#{inputFile}' -vf -filter_complex \"subtitles='#{inputFile}'\" -c:v libvpx -crf 10 -b:v 1M -c:a libvorbis -y '#{outputFile}'"

    # For mp4
    #command = "#{binExecutable} -i '#{inputFile}' -map 0 -c copy -c:a aac '#{outputFile}'"

    log(
      "ffmpeg"
      "Attempting to convert from video source from #{oldFormat} to #{newFormat}."
    )
    exec command, (err, stdout, stderr) ->
      if err
        log "ffmpeg error", err.message
        reject()

      log "ffmpeg", "Conversion done."
      resolve newFileName

extractSubtitles = (fileName) ->
  # Create folder if it doesnt exist
  if !fs.existsSync path
    fs.mkdirSync path

  new Promise (resolve, reject) ->
    subsFile = "#{fileName.replace oldFormat, ""}#{subsFormat}"

    inputFile = "#{path}/#{fileName}"
    outputFile = "#{path}/#{subsFile}"

    command = "#{binExecutable} -i '#{inputFile}' -map 0:s:0 -y '#{outputFile}'"

    log "ffmpeg", "Attempting to extract subtitles from media source."
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
    log "answer", "Retrieved subtitles from media source."
    videoFile = await convertVideo fileName
    videoFilePath = "#{virtualPath}/#{videoFile}"
    # Comment the following line if you uncommented the previous block
    #videoFilePath = "#{virtualPath}/#{fileName}"

    subsFile = await extractSubtitles fileName
    subsFilePath = "#{virtualPath}/#{subsFile}"
    log "answer", "Retrieved subtitles from media source."

    return videoFilePath: videoFilePath, subsFilePath: subsFilePath
  catch
    log "error", "Error trying to convert media source."
