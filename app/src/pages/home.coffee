import { ScheduleList, ScheduleListSkeleton } from "../components/scheduleList.coffee"
import { CarouselSkeleton, ShowsCarousel } from "../components/carousel.coffee"
import { ScheduleSlider, SliderSkeleton } from "../components/slider.coffee"

export Home = ({ scheduleData, isScheduleLoading }) ->
  <div className="flex-1">
    {if isScheduleLoading
      <>
        <CarouselSkeleton />
        <SliderSkeleton />
        <ScheduleListSkeleton />
      </>
    else
      <>
        <ShowsCarousel scheduleData={scheduleData} />
        <ScheduleSlider scheduleData={scheduleData} />
        <ScheduleList scheduleData={scheduleData} />
      </>
    }
  </div>
