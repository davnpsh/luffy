import { Link } from "react-router-dom"
import axios from "axios"
import { Carousel, Typography, Button } from "@material-tailwind/react"
import { useState, useEffect } from "react"

export CarouselSkeleton = ->
  <div style={height: "50vh"}>
    <Carousel autoplay={true} loop={true}>
      {Array 3
        .fill()
        .map (_, index) ->
          <div className="relative h-full w-full" key={index}>
            <div className="absolute inset-0 grid h-full w-full place-items-center bg-black/75 ">
              <div className="w-3/4 md:w-2/4 animate-pulse flex items-center justify-center flex-col mt-52">
                <Typography
                  as="div"
                  variant="h1"
                  color="white"
                  className="mb-4 h-7 w-2/3 rounded-full bg-gray-600"
                >
                  &nbsp;
                </Typography>
                <Typography
                  as="div"
                  variant="h1"
                  color="white"
                  className="mb-4 h-4 w-3/4 rounded-full bg-gray-300"
                >
                  &nbsp;
                </Typography>
                <Typography
                  as="div"
                  variant="h1"
                  color="white"
                  className="mb-4 h-4 w-2/4 rounded-full bg-gray-300"
                >
                  &nbsp;
                </Typography>
                <Typography
                  as="div"
                  variant="h1"
                  color="white"
                  className="mb-4 h-4 w-3/5 rounded-full bg-gray-300"
                >
                  &nbsp;
                </Typography>
              </div>
            </div>
          </div>
        }
    </Carousel>
  </div>

export ShowsCarousel = ({ scheduleData }) ->
  [randomShows, setRandomShows] = useState []
  [carouselData, setCarouselData] = useState []
  [isCarouselDataLoading, setIsCarouselDataLoading] = useState true

  # Fetch those shows names and release years
  useEffect(
    ->
      getRandomShows = ->
        days = Object.keys scheduleData
        randomDay = days[Math.floor Math.random() * days.length]
        randomShows = scheduleData[randomDay]
          .sort -> Math.random() - 0.5
          .slice 0, 3
        setRandomShows randomShows

      fetchShowDetails = ->
        axios
          .post "/api/carousel", shows: randomShows
          .then (response) ->
            setCarouselData response.data
            setIsCarouselDataLoading false
          .catch (error) ->
            return error

      getRandomShows()
      fetchShowDetails()
      return
  ,
    []
  )

  if isCarouselDataLoading
    return <CarouselSkeleton />

  <div style={height: "50vh"}>
    <Carousel autoplay={true} loop={true}>
      {carouselData.map (show, index) ->
        <div className="relative h-full w-full" key={index}>
          <img
            src={show.images.backdrop}
            alt={show.name}
            className="h-full w-full object-cover"
          />
          <div className="absolute inset-0 grid h-full w-full place-items-center bg-black/75">
            <div className="w-3/4 text-center md:w-2/4 mt-40 sm:mt-32">
              <Typography
                variant="h1"
                color="white"
                className="mb-4 text-3xl md:text-4xl lg:text-5xl"
              >
                {randomShows[index].name}
              </Typography>
              <Typography
                variant="lead"
                color="white"
                className="mb-5 opacity-80 text-lg hidden sm:block"
              >
                {show.overview[0..200] + "..."}
              </Typography>
              <div className="mb-5 flex justify-center sm:mb-12">
                <Link
                  to={"/watch?s=#{randomShows[index].identifier}"}
                >
                  <Button size="lg" color="white">
                    Watch now
                  </Button>
                </Link>
              </div>
            </div>
          </div>
        </div>
      }
    </Carousel>
  </div>
