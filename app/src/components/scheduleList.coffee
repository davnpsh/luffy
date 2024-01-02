import Slider from "react-slick"
import { ShowCard } from "./showCard.coffee"
import { Typography } from "@material-tailwind/react"
import "slick-carousel/slick/slick.css"
import "slick-carousel/slick/slick-theme.css"

ScheduleDay = ({ day, shows }) ->
  settings =
    dots: false
    slidesToShow: 5
    slidesToScroll: 1
    speed: 500

  <div className="mt-4 mb-4">
    <Typography
      variant="h3"
      color="white"
      className="mb-4 ml-5 md:ml-0 text-xl md:text-2xl"
    >
      {day}
    </Typography>
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

export ScheduleList = ({ scheduleData }) ->
  <section className="container mx-auto mt-10 mb-10" id="schedule">
    <Typography
      variant="h2"
      color="white"
      className="mb-4 ml-5 md:ml-0 text-2xl md:text-3xl text-center"
    >
      Schedule
    </Typography>
    <div>
      {Object.keys(scheduleData).map (day) ->
        <ScheduleDay day={day} shows={scheduleData[day]} />
      }
    </div>
  </section>
