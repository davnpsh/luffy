import axios from "axios"
import { useState, useEffect } from "react"
import { List, ListItem, Typography, Spinner } from "@material-tailwind/react"

EpisodesListSkeleton = ->
  <div className="grid place-items-center mt-5">
    <Spinner className="h-10 w-10" />
  </div>

Episode = ({ image, number, title, description, link }) ->
  <a href={link}>
    <ListItem className="flex flex-col md:flex-row gap-5 group">
      <div className="md:w-1/3 h-full flex items-center">
        <img src={image} className="object-cover" />
      </div>
      <div className="md:w-2/3">
        <Typography
          variant="h6"
          color="white"
          className="mb-2 group-hover:text-ctp-base transition-all ease-out"
        >
          {number}. {title}
        </Typography>
        <Typography
          variant="small"
          color="white"
          className="font-normal opacity-50 group-hover:text-ctp-base transition-all ease-out"
        >
          {description}
        </Typography>
      </div>
    </ListItem>
  </a>

export EpisodesList = ({ watchData }) ->
  [episodesListData, setEpisodesListData] = useState null
  [areEpisodesLoading, setAreEpisodesLoading] = useState true

  urlParams = new URLSearchParams window.location.search

  # Param on address bar
  showURL = urlParams.get "s"

  useEffect(
    ->
      fetchEpisodesListData = ->
        axios
          .post "/api/episodes/list",
            showID: watchData.id, season: watchData.season, showURL: showURL
          .then (response) ->
            setEpisodesListData response.data
            setAreEpisodesLoading false
          .catch (error) ->
            return error

      fetchEpisodesListData()
      return
  ,
    []
  )

  if areEpisodesLoading
    <EpisodesListSkeleton />
  else
    <div>
      <List className="mb-10">
        {
          for own episode, data of episodesListData
            <Episode
              image={data["image"]}
              number={episode}
              title={data["name"]}
              description={data["overview"]}
              link={"/watch?s=#{showURL}&e=#{episode}"}
              key={episode}
            />
        }
      </List>
    </div>
