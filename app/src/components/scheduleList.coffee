import Slider from "react-slick"
import { ShowCard } from "./showCard.coffee"
import { Typography, Spinner } from "@material-tailwind/react"
import "slick-carousel/slick/slick.css"
import "slick-carousel/slick/slick-theme.css"

export ScheduleListSkeleton = ->
  <section className="container mx-auto mt-10 mb-10" id="schedule">
    <Typography
      variant="h2"
      color="white"
      className="mb-4 md:ml-0 text-2xl md:text-3xl text-center"
    >
      Schedule
    </Typography>
    <div className="grid place-items-center mt-3">
      <Spinner className="h-10 w-10" />
    </div>
  </section>

ScheduleDay = ({ day, shows }) ->
  settings =
    dots: false
    slidesToShow: 5
    slidesToScroll: 1
    speed: 500
    responsive: [
      {
      breakpoint: 850
      settings:
        slidesToShow: 4
        arrows: false
        touchMove: true
      }
      {
      breakpoint: 640
      settings:
        slidesToShow: 3
        arrows: false
        touchMove: true
      }
    ]

  <div className="mt-4 mb-4">
    <Typography
      variant="h3"
      color="white"
      className="mb-4 ml-5 md:ml-0 text-xl md:text-2xl"
    >
      {day}
    </Typography>
    <div className="hidden lg:block">
      {if shows.length < 5
        shows.map((show) ->
          <ShowCard
            url={show.identifier}
            picurl={show.picture}
            name={show.name}
          />
        )
      else
        <Slider {...settings}>
          {shows.map (show) ->
            <ShowCard
              url={show.identifier}
              picurl={show.picture}
              name={show.name}
            />
          }
        </Slider>
      }
    </div>
    <div className="hidden md:block lg:hidden">
      {if shows.length < 4
        shows.map((show) ->
          <ShowCard
            url={show.identifier}
            picurl={show.picture}
            name={show.name}
          />
        )
      else
        <Slider {...settings}>
          {shows.map (show) ->
            <ShowCard
              url={show.identifier}
              picurl={show.picture}
              name={show.name}
            />
          }
        </Slider>
      }
    </div>
    <div className="block md:hidden">
      {if shows.length < 3
        shows.map((show) ->
          <ShowCard
            url={show.identifier}
            picurl={show.picture}
            name={show.name}
          />
        )
      else
        <Slider {...settings}>
          {shows.map (show) ->
            <ShowCard
              url={show.identifier}
              picurl={show.picture}
              name={show.name}
            />
          }
        </Slider>
      }
    </div>
  </div>

export ScheduleList = ({ scheduleData }) ->
  <section className="container mx-auto mt-10 mb-10" id="schedule">
    <Typography
      variant="h2"
      color="white"
      className="mb-4 md:ml-0 text-2xl md:text-3xl text-center"
    >
      Schedule
    </Typography>
    <div>
      {Object.keys(scheduleData).map (day) ->
        <ScheduleDay day={day} shows={scheduleData[day]} />
      }
    </div>
  </section>
