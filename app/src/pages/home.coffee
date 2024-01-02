import { CarouselSkeleton, ShowsCarousel } from "../components/carousel.coffee"
import { ScheduleSlider } from "../components/slider.coffee"

export Home = ({ scheduleData, isScheduleLoading }) ->
  <div>
    {if isScheduleLoading
      <>
        <CarouselSkeleton />
      </>
    else
      <>
        <ShowsCarousel scheduleData={scheduleData} />
        <ScheduleSlider scheduleData={scheduleData} />
      </>
    }
  </div>
