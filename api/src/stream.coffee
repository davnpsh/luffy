import { log } from "./logger.coffee"
import * as scrapper from "./scrapper.coffee"
import WebTorrent from "webtorrent-hybrid"
import * as ffmpeg from "./converter.coffee"
import fs from "fs"

client = new WebTorrent()

# Relative path to the root folder
path = "./public"

# Get filename and DESTROY (it would be nice to seed, but webtorrent doesnt handle duplicates very well)
getFileName = (torrent) ->
  new Promise (resolve, reject) ->
    torrent.on "done", ->
      # There will be only 1 file
      fileName = torrent.files[0].name
      torrent.destroy destroyStore: false

      resolve fileName

download = (magnetURI) ->
  # Create folder if it doesnt exist
  if !fs.existsSync path
    fs.mkdirSync path

  torrent = await client.add magnetURI, path: path
  log "webtorrent client", "Added magnetURI for #{torrent.name}."

  log "webtorrent client", "Starting download for #{torrent.name}."
  torrent.on "download", (bytes) ->
    progress = parseInt torrent.progress * 100
    downloadSpeed = (torrent.downloadSpeed / 1024 ** 2).toFixed 2 # Get MB/s
    uploadSpeed = (torrent.uploadSpeed / 1024 ** 2).toFixed 2 # Get MB/s

    if progress isnt 100
      log(
        "webtorrent client"
        "#{
          torrent.name
        } - (#{progress}%) [↓ #{downloadSpeed} MBytes/s | ↑ #{uploadSpeed} MBytes/s]."
      )

  torrent.on "done", ->
    log "webtorrent client", "Downloaded #{torrent.name}"

  torrent

getMagnetURI = (showURL, episodeNumber, quality) ->
  episodesList = await scrapper.getShowEpisodes showURL

  for own fetchedEpisode, qualities of episodesList
    if fetchedEpisode is episodeNumber
      for own fetchedQuality, magnetURI of qualities
        if fetchedQuality is quality
          return magnetURI

export stream = (showURL, episodeNumber, quality) ->
  try
    magnetURI = await getMagnetURI showURL, episodeNumber, quality
    torrent = await download magnetURI
    fileName = await getFileName torrent

    convertedFiles = await ffmpeg.convert fileName

    log "answer", "Fetched media files to stream."
    return convertedFiles
  catch
    log "error", "Error trying to fetch media files to stream."
    return null
