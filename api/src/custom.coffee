import * as scrapper from "./scrapper.coffee"
import * as tmdb from "./tmdb.coffee"
import { log } from "./logger.coffee"

# Remove " SX" from name string
removeSeason = (name) ->
  name.replace(/ S\d+$/, "")

export getCarouselData = (shows) ->
  try
    data = []

    for show in shows
      showID = await tmdb.getShowID removeSeason show.name
      details = await tmdb.getShowDetails showID.id

      data.push details

    log "answer", "Fetched carousel data."
    return data
  catch
    log "error", "Error trying to fetch carousel data."
    return null
