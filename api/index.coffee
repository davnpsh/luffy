import { log } from "./src/logger.coffee"
import * as scrapper from "./src/scrapper.coffee"
import * as tmdb from "./src/tmdb.coffee"
import * as custom from "./src/custom.coffee"
import express from "express"
import * as stream from "./src/stream.coffee"

ADDRESS = "127.0.0.1"
PORT = 3000

api = express()
api.use express.json()

# @route GET /api/video
# @returns video file
api.use "/api/video", express.static "./public"

# @route GET /api/schedule
# @returns {Object} with schedule
api.get "/api/schedule", (req, res) ->
  log "request", "Request to fetch schedule from #{req.ip}."
  res.send await scrapper.getSchedule()

# @route POST /api/episodes/magnets
# @param showURL - string (must be from Subsplease)
# @returns {Object} with episodes magnet links
api.post "/api/episodes/magnets", (req, res) ->
  data = req.body

  log "request", "Request to fetch episodes from #{req.ip}."
  res.send await scrapper.getShowEpisodes data.showURL

# @route POST /api/show/year
# @param showURL - string (must be from Subsplease)
# @returns {Object} with name and release year
api.post "/api/show/profile", (req, res) ->
  data = req.body

  log "request", "Request to fetch show name and release year from #{req.ip}."
  res.send await scrapper.getShowProfile data.showURL

# @route POST /api/show/id
# @param showName - string
#        showYear - string (optional)
# @returns showID - int32
api.post "/api/show/id", (req, res) ->
  data = req.body

  log "request", "Request to fetch show TMDB ID from #{req.ip}."
  res.send await tmdb.getShowID data.showName, data.showYear

# @route POST /api/show/details
# @param showID - int32
# @returns {Object} with show details
api.post "/api/show/details", (req, res) ->
  data = req.body

  log "request", "Request to fetch show details from #{req.ip}."
  res.send await tmdb.getShowDetails data.showID

# @route POST /api/show/episode_details
# @param showID - int32
#        seasonNumber - int32
#        episodeNumber - int32
# @returns {Object} with episode details
api.post "/api/episode/details", (req, res) ->
  data = req.body

  log "request", "Request to fetch episode details from #{req.ip}."
  res.send(
    await tmdb.getEpisodeDetails(
      data.showID
      data.seasonNumber
      data.episodeNumber
    )
  )

# @route POST /api/carousel
# @param shows - Object
# @returns {Object} with carousel data
api.post "/api/carousel", (req, res) ->
  data = req.body

  log "request", "Request to fetch carousel data from #{req.ip}"
  res.send await custom.getCarouselData data.shows

# @route POST /api/watch/details
# @param showURL - string (must be from Subsplease)
# @returns {Object} with show details
api.post "/api/watch/details", (req, res) ->
  data = req.body

  log "request", "Request to fetch watch data from #{req.ip}"
  res.send await custom.getWatchData data.showURL

# @route POST /api/episodes/list
# @param showURL - string (must be from Subsplease)
# @returns {Object} with episodes list with details
api.post "/api/episodes/list", (req, res) ->
  data = req.body

  log "request", "Request to fetch episodes list from #{req.ip}"
  res.send await custom.getEpisodesList data.showID, data.season, data.showURL

# @route POST /api/episode/stream
# @param showURL - string (must be from Subsplease)
#        episodeNumber - string
# @returns {Object} with video path
api.post "/api/episode/stream", (req, res) ->
  data = req.body

  log "request", "Request to stream"
  res.send await stream.stream data.showURL, data.episodeNumber, data.quality

api.listen PORT, ADDRESS, ->
  log "access", "Listening on http://#{ADDRESS}:#{PORT}/api"
