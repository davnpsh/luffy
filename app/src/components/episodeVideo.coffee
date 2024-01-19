import {
  Typography
  ButtonGroup
  Button
  List
  ListItem
  Spinner
} from "@material-tailwind/react"
import axios from "axios"
import { useState, useEffect } from "react"

MainSkeleton = ->
  <div className="container w-full m-auto flex flex-col lg:flex-row gap-5 animate-pulse">
    <div className="w-full lg:w-2/3 flex flex-col">
      <div className="w-full mb-5">
        <div className="grid my-5 h-96 w-full animate-pulse place-items-center rounded-lg bg-gray-300">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            strokeWidth={2}
            stroke="currentColor"
            className="h-12 w-12 text-gray-500"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="m15.75 10.5 4.72-4.72a.75.75 0 0 1 1.28.53v11.38a.75.75 0 0 1-1.28.53l-4.72-4.72M4.5 18.75h9a2.25 2.25 0 0 0 2.25-2.25v-9a2.25 2.25 0 0 0-2.25-2.25h-9A2.25 2.25 0 0 0 2.25 7.5v9a2.25 2.25 0 0 0 2.25 2.25Z"
            />
          </svg>
        </div>
      </div>
      <div className="w-full px-4">
        <Typography
          variant="h1"
          className="h-5 w-full rounded-full bg-gray-300 mb-2"
        >
          &nbsp;
        </Typography>
        <Typography variant="h2" className="h-4 w-44 rounded-full bg-gray-300">
          &nbsp;
        </Typography>
        <div className="mt-5">
          <Typography
            variant="paragraph"
            className="h-2 w-full rounded-full bg-gray-500 mb-1"
          >
            &nbsp;
          </Typography>
          <Typography
            variant="paragraph"
            className="h-2 w-11/12 rounded-full bg-gray-500 mb-1"
          >
            &nbsp;
          </Typography>
          <Typography
            variant="paragraph"
            className="h-2 w-11/12 rounded-full bg-gray-500 mb-1"
          >
            &nbsp;
          </Typography>
          <Typography
            variant="paragraph"
            className="h-2 w-2/3 rounded-full bg-gray-500 mb-1"
          >
            &nbsp;
          </Typography>
        </div>
      </div>
    </div>
    <div className="w-full lg:w-1/3">
      <div className="w-full h-[60vh] bg-gray-400 hidden lg:block" />
    </div>
  </div>

Episode = ({ image, number, title, description, link }) ->
  urlParams = new URLSearchParams window.location.search

  # Param on address bar
  episodeNumber = urlParams.get "e"

  if number is episodeNumber
    <ListItem className="flex flex-row gap-5 group" selected={true}>
      <div className="w-1/3 h-full flex items-center">
        <img src={image} className="object-cover" />
      </div>
      <div className="w-2/3">
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
          {"#{description[0..50]}..."}
        </Typography>
      </div>
    </ListItem>
  else
    <a href={link}>
      <ListItem className="w-full flex flex-row gap-5 group">
        <div className="w-1/3 h-full flex items-center">
          <img src={image} className="object-cover" />
        </div>
        <div className="w-2/3">
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
            {"#{description[0..50]}..."}
          </Typography>
        </div>
      </ListItem>
    </a>

EpisodesListSkeleton = ->
  <div className="grid place-items-center mt-5">
    <Spinner className="h-10 w-10" />
  </div>

EpisodesList = ({ watchData }) ->
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
    <div className="w-full rounded-lg lg:border lg:border-white">
      <div className="w-full p-4 hidden lg:block">
        <Typography variant="h3" className="text-white text-xl">
          {watchData["name"]}
        </Typography>
        <Typography variant="h4" className="text-white text-md">
          Season {watchData["season"]}
        </Typography>
      </div>
      <div className="w-full p-4 lg:hidden">
        <Typography variant="h3" className="text-white text-xl">
          More episodes...
        </Typography>
      </div>
      <div className="w-full lg:overflow-y-auto lg:max-h-[60vh]">
        <List>
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
    </div>

Video = ({ watchData, quality }) ->
  [videoData, setVideoData] = useState null
  [isVideoLoading, setIsVideoLoading] = useState true

  urlParams = new URLSearchParams window.location.search

  # Params on address bar
  showURL = urlParams.get "s"
  episodeNumber = urlParams.get "e"

  useEffect(
    ->
      fetchVideoData = ->
        axios
          .post "/api/episode/stream",
            showURL: showURL, episodeNumber: episodeNumber, quality: quality
          .then (response) ->
            setVideoData response.data
            setIsVideoLoading false
          .catch (error) ->
            return error

      fetchVideoData()
      return
  ,
    []
  )

  if isVideoLoading
    <div className="grid my-5 h-56 md:h-96 w-full rounded-lg overflow-hidden relative">
      <img
        src={watchData.images.backdrop}
        alt={watchData.name}
        className="h-full w-full object-cover"
      />
      <div className="absolute inset-0 grid h-full w-full place-items-center bg-black/75">
        <Spinner className="h-10 w-10" />
        <Typography
          variant="paragraph"
          color="white"
          className="text-md font-normal absolute mt-24"
        >
          This may take minutes...
        </Typography>
      </div>
    </div>
  else
    <div className="my-5">
      <video controls>
        <source src={videoData.videoFilePath} type="video/webm" />
      </video>
    </div>

QualityButtons = ({ setQuality }) ->
  <>
    <ButtonGroup color="white" className="hidden lg:block">
      <Button onClick={-> setQuality "480p"}>480p</Button>
      <Button onClick={-> setQuality "720p"}>720p</Button>
      <Button onClick={-> setQuality "1080p"}>1080p</Button>
    </ButtonGroup>
    <ButtonGroup color="white" fullWidth className="lg:hidden px-4">
      <Button onClick={-> setQuality "480p"}>480p</Button>
      <Button onClick={-> setQuality "720p"}>720p</Button>
      <Button onClick={-> setQuality "1080p"}>1080p</Button>
    </ButtonGroup>
  </>

Main = ({ watchData }) ->
  [quality, setQuality] = useState "480p"

  urlParams = new URLSearchParams window.location.search

  # Params on address bar
  episodeNumber = urlParams.get "e"

  <div className="container w-full m-auto flex flex-col lg:flex-row gap-5">
    <div className="w-full lg:w-2/3 flex flex-col">
      <div className="w-full">
        <QualityButtons setQuality={setQuality} />
      </div>
      <div className="w-full">
        <Video watchData={watchData} quality={quality} />
      </div>
      <div className="w-full px-4">
        <Typography variant="h1" className="text-white text-2xl">
          {watchData["name"]}
        </Typography>
        <Typography variant="h2" className="text-white text-lg">
          Season {watchData["season"]}, Episode {episodeNumber}
        </Typography>
        <hr className="border-ctp-overlay0 my-4 w-full" />
        <Typography
          variant="paragraph"
          className="text-white text-md font-normal"
        >
          {
            if watchData["season"] > 1
              for season in watchData["seasons"]
                if season["number"] is watchData["season"]
                  overview = season["overview"]

                  if overview is ""
                    overview = watchData["overview"]
            else
              overview = watchData["overview"]

            overview
          }
        </Typography>
      </div>
    </div>
    <div className="w-full lg:w-1/3">
      <EpisodesList watchData={watchData} />
    </div>
  </div>

export EpisodeVideo = ({ watchData, isWatchDataLoading }) ->
  if isWatchDataLoading
    <>
      <MainSkeleton />
    </>
  else
    <>
      <Main watchData={watchData} />
    </>
