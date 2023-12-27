###
TheMovieDB api
CREDITS: https://developer.themoviedb.org/
###

import { log } from "./logger.coffee"
import "dotenv/config"
import axios from "axios"

BASE_DOMAIN =
  API: "https://api.themoviedb.org/3"
  IMAGE:
    ORIGINAL: "https://image.tmdb.org/t/p/original"
    LOW_RES: "https://image.tmdb.org/t/p/w500"

API_KEY = process.env.TMDB_API_KEY

# It requires name and year since
# filtering is not viable
export getShowID = (name, year) ->
  options =
    method: "GET"
    url: """
            #{BASE_DOMAIN.API}/search/tv?
            query=#{name}
            &include_adult=true
            &language=en-US
            &page=1
            &year=#{year}
            &api_key=#{API_KEY}
        """
    headers:
      accept: "application/json"

  axios
    .request options
    .then (response) ->
      # Return always first result
      showID = response.data["results"][0]["id"]

      log "answer", "Fetched show ID #{showID}."
      return showID
    .catch (error) ->
      log "error", "Error trying to get show ID: \n" + error
      return null

# General details
export getShowDetails = (showID) ->
  options =
    method: "GET"
    url: """
            #{BASE_DOMAIN.API}/tv/
            #{showID}?
            language=en-US
            &api_key=#{API_KEY}
        """
    headers:
      accept: "application/json"

  axios
    .request options
    .then (response) ->
      showDetails =
        id: response.data["id"]
        name: response.data["name"]
        overview: response.data["overview"]
        images:
          poster: BASE_DOMAIN.IMAGE.ORIGINAL + response.data["poster_path"]
          backdrop: BASE_DOMAIN.IMAGE.ORIGINAL + response.data["backdrop_path"]
        seasons: response.data["seasons"].map (season) ->
          number: season["season_number"]
          overview: season["overview"]
          images:
            poster: BASE_DOMAIN.IMAGE.LOW_RES + season["poster_path"]

      log "answer", "Fetched show details for show ID #{showDetails.id}."
      return showDetails
    .catch (error) ->
      log "error", "Error trying to get show details: \n" + error
      return null

export getEpisodeDetails = (showID, seasonNumber, episodeNumber) ->
  options =
    method: "GET"
    url: """
            #{BASE_DOMAIN.API}/tv/
            #{showID}/
            season/#{seasonNumber}/
            episode/#{episodeNumber}?
            language=en-US
            &api_key=#{API_KEY}
        """
    headers:
      accept: "application/json"

  axios
    .request options
    .then (response) ->
      # Return always first result
      episodeDetails =
        id: response.data["id"]
        name: response.data["name"]
        overview: response.data["overview"]
        seasonNumber: response.data["season_number"]
        image: BASE_DOMAIN.IMAGE.LOW_RES + response.data["still_path"]

      log "answer", "Fetched details for episode ID #{episodeDetails.id}."
      return episodeDetails
    .catch (error) ->
      log "error", "Error trying to get episode details: \n" + error
      return null
