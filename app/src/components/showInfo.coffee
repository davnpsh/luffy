import { Typography, Spinner } from "@material-tailwind/react"

HeaderSkeleton = ->
  <section className="relative">
    <div className="w-full md:h-80">
      <div className="bg-gray-300 w-full h-full grid place-items-center animate-pulse py-48 md:py-0">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          strokeWidth={2}
          stroke="currentColor"
          className="h-36 w-36 text-gray-500"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            d="m2.25 15.75 5.159-5.159a2.25 2.25 0 0 1 3.182 0l5.159 5.159m-1.5-1.5 1.409-1.409a2.25 2.25 0 0 1 3.182 0l2.909 2.909m-18 3.75h16.5a1.5 1.5 0 0 0 1.5-1.5V6a1.5 1.5 0 0 0-1.5-1.5H3.75A1.5 1.5 0 0 0 2.25 6v12a1.5 1.5 0 0 0 1.5 1.5Zm10.5-11.25h.008v.008h-.008V8.25Zm.375 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Z"
          />
        </svg>
      </div>
      <div className="absolute inset-0 grid h-full w-full place-items-center md:bg-black/50" />
    </div>
    <div className="absolute bottom-0 py-4 w-full bg-black/75">
      <div className="container w-full h-full m-auto flex flex-row">
        <div className="h-full lg:w-1/3" />
        <div className="h-full w-full lg:w-2/3 px-4 md:px-0 animate-pulse">
          <Typography
            as="div"
            variant="h1"
            color="white"
            className="h-4 w-2/3 mb-3 rounded-full bg-gray-300"
          >
            &nbsp;
          </Typography>
          <Typography
            as="div"
            variant="h2"
            color="white"
            className="h-2 w-1/3 rounded-full bg-gray-300"
          >
            &nbsp;
          </Typography>
        </div>
      </div>
    </div>
  </section>

MainSkeleton = ->
  <section>
    <div className="container w-full m-auto flex flex-row">
      <div className="h-full lg:w-1/3 relative flex justify-center">
        <div className="w-4/5 object-cover rounded-lg absolute -top-48 hidden lg:block pt-[120%]">
          <div className="bg-gray-300 place-items-center animate-pulse w-full h-full grid absolute top-0">
            <Spinner className="h-12 w-12"/>
          </div>
        </div>
      </div>
      <div className="h-full w-full lg:w-2/3 flex flex-col justify-center px-4 md:px-0 animate-pulse">
        <Typography
          as="div"
          variant="paragraph"
          color="white"
          className="h-3 w-full rounded-full bg-gray-500 mt-4"
        >
          &nbsp;
        </Typography>
        <Typography
          as="div"
          variant="paragraph"
          color="white"
          className="h-3 w-4/6 rounded-full bg-gray-500 mt-2"
        >
          &nbsp;
        </Typography>
        <Typography
          as="div"
          variant="paragraph"
          color="white"
          className="h-3 w-5/6 rounded-full bg-gray-500 mt-2"
        >
          &nbsp;
        </Typography>
      </div>
    </div>
  </section>

Main = ({ watchData }) ->
  <section>
    <div className="container w-full m-auto flex flex-row">
      <div className="h-full lg:w-1/3 relative flex justify-center">
        <img
          src={
            if watchData["season"] > 1
              for season in watchData["seasons"]
                if season["number"] is watchData["season"]
                  poster = season["images"]["poster"]
            else
              poster = watchData["images"]["poster"]

            poster
          }
          className="w-4/5 object-cover rounded-lg absolute -top-48 hidden lg:block"
        />
      </div>
      <div className="h-full lg:w-2/3 flex flex-col justify-center px-4 md:px-0">
        <Typography
          as="div"
          variant="paragraph"
          color="white"
          className="font-normal mt-5"
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
  </section>

Header = ({ watchData }) ->
  <section className="relative">
    <div className="w-full md:h-80">
      <img
        src={watchData["images"]["backdrop"]}
        className="h-full w-full object-cover hidden md:block"
      />
      <img
        src={
          if watchData["season"] > 1
            for season in watchData["seasons"]
              if season["number"] is watchData["season"]
                poster = season["images"]["poster"]
          else
            poster = watchData["images"]["poster"]

          poster
        }
        className="h-full w-full object-cover block md:hidden"
      />
      <div className="absolute inset-0 grid h-full w-full place-items-center md:bg-black/50" />
    </div>
    <div className="absolute bottom-0 py-4 w-full bg-black/75">
      <div className="container w-full h-full m-auto flex flex-row">
        <div className="h-full lg:w-1/3" />
        <div className="h-full lg:w-2/3 px-4 md:px-0">
          <Typography as="div" variant="h1" color="white" className="text-3xl">
            {watchData["name"]}
          </Typography>
          <Typography as="div" variant="h2" color="white" className="text-xl">
            Season {watchData["season"]}
          </Typography>
        </div>
      </div>
    </div>
  </section>

export ShowInfo = ({ watchData, isWatchDataLoading }) ->
  if isWatchDataLoading
    <>
      <HeaderSkeleton />
      <MainSkeleton />
    </>
  else
    <>
      <Header watchData={watchData} />
      <Main watchData={watchData} />
    </>
