import { log } from "./src/logger.coffee"
import * as scrapper from "./src/scrapper.coffee"
import * as tmdb from "./src/tmdb.coffee"
import express from "express"


ADDRESS = "127.0.0.1"
PORT = 3000


api = express()
api.use express.json()


api.get "/api/schedule", ( req, res ) ->
    log "request", "Request to fetch schedule from #{ req.ip }."
    res.send await scrapper.getSchedule()


api.post "/api/show/episodes", ( req, res ) ->
    data = req.body

    log "request", "Request to fetch episodes from #{ req.ip }."
    res.send await scrapper.getShowEpisodes data.showURL


api.post "/api/show/year", ( req, res ) ->
    data = req.body

    log "request", "Request to fetch show release year from #{ req.ip }."
    res.send await scrapper.getShowYear data.showURL


api.post "/api/show/id", ( req, res ) ->
    data = req.body

    log "request", "Request to fetch show TMDB ID from #{ req.ip }."
    res.send await tmdb.getShowID data.showName, data.showYear


api.post "/api/show/details", ( req, res ) ->
    data = req.body

    log "request", "Request to fetch show details from #{ req.ip }."
    res.send await tmdb.getShowDetails data.showID


api.post "/api/show/episode_details", ( req, res ) ->
    data = req.body

    log "request", "Request to fetch episode details from #{ req.ip }."
    res.send await tmdb.getEpisodeDetails data.showID, data.seasonNumber, data.episodeNumber


api.listen PORT, ADDRESS, () ->
    log "access", "Listening on http://#{ ADDRESS }:#{ PORT }/api"