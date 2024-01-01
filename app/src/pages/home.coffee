import { CarouselSkeleton, ShowsCarousel } from "../components/carousel.coffee"

export Home = ({ scheduleData, isScheduleLoading }) ->
  <section>
    {
      if isScheduleLoading
        <CarouselSkeleton />
      else
        <ShowsCarousel scheduleData={scheduleData} />
    }
  </section>
