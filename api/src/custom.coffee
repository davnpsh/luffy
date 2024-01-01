import * as scrapper from "./scrapper.coffee"
import * as tmdb from "./tmdb.coffee"
import { log } from "./logger.coffee"

export getCarouselData = (shows) ->
  try
    data = []

    for show in shows
      profile = await scrapper.getShowProfile show.identifier
      showID = await tmdb.getShowID profile.name, show.year
      details = await tmdb.getShowDetails showID.id

      data.push details

    log "answer", "Fetched carousel data."
    return data
  catch
    log "error", "Error trying to fetch carousel data."
    return null
