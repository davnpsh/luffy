import { Carousel, Typography } from "@material-tailwind/react"

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
