import { EpisodeVideo } from "../components/episodeVideo.coffee"
import axios from "axios"
import { useState, useEffect } from "react"
import { ShowInfo } from "../components/showInfo.coffee"
import { Navigate } from "react-router-dom"

export Watch = ->
  [watchData, setWatchData] = useState null
  [isWatchDataLoading, setIsWatchDataLoading] = useState true

  urlParams = new URLSearchParams window.location.search

  # Params on address bar
  showURL = urlParams.get "s"
  episodeNumber = urlParams.get "e"

  useEffect(
    ->
      fetchWatchDetails = ->
        axios
          .post "/api/watch/details", showURL: showURL
          .then (response) ->
            setWatchData response.data
            setIsWatchDataLoading false
          .catch (error) ->
            return error

      fetchWatchDetails()
      return
  ,
    []
  )

  # In case the query returns an empty string
  if watchData is ""
    <Navigate replace to="/error" />
  # If not
  else
    <div className="flex-1">
      {if episodeNumber
        <EpisodeVideo
          watchData={watchData}
          isWatchDataLoading={isWatchDataLoading}
        />
      else
        <>
          <ShowInfo
            watchData={watchData}
            isWatchDataLoading={isWatchDataLoading}
          />
        </>
      }
    </div>
