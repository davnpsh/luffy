import { Typography } from "@material-tailwind/react"

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
    <></>
  else
    <>
      <Header watchData={watchData} />
      <Main watchData={watchData} />
    </>
