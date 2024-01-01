import * as scrapper from "./scrapper.coffee"
import * as tmdb from "./tmdb.coffee"
import { log } from "./logger.coffee"

removeSeason = (profile) ->
  profile.name = profile.name.replace(/ S\d+$/, "")
  profile

export getCarouselData = (shows) ->
  try
    data = []

    for show in shows
      profile = removeSeason await scrapper.getShowProfile show.identifier
      showID = await tmdb.getShowID profile.name, show.year
      details = await tmdb.getShowDetails showID.id

      data.push details

    log "answer", "Fetched carousel data."
    return data
  catch
    log "error", "Error trying to fetch carousel data."
    return null
