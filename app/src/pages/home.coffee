import { CarouselSkeleton, ShowsCarousel } from "../components/carousel.coffee"
import { ScheduleSlider, SliderSkeleton } from "../components/slider.coffee"

export Home = ({ scheduleData, isScheduleLoading }) ->
  <div>
    {if isScheduleLoading
      <>
        <CarouselSkeleton />
        <SliderSkeleton />
      </>
    else
      <>
        <ShowsCarousel scheduleData={scheduleData} />
        <ScheduleSlider scheduleData={scheduleData} />
      </>
    }
  </div>
