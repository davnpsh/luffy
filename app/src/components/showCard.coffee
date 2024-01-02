import {
  Card
  CardHeader
  CardBody
  Typography
} from "@material-tailwind/react"
import { Link } from "react-router-dom"

export CardSkeleton = ->
  <Card
    shadow={false}
    className="relative grid h-[318px] w-[225px] items-end overflow-hidden text-left animate-pulse"
  >
    <CardHeader
      floated={false}
      shadow={false}
      color="transparent"
      className="absolute inset-0 m-0 h-full w-full rounded-none"
    >
      <div className="grid h-full w-full place-items-center rounded-lg bg-gray-300">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          strokeWidth={2}
          stroke="currentColor"
          className="h-12 w-12 text-gray-500"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            d="m2.25 15.75 5.159-5.159a2.25 2.25 0 0 1 3.182 0l5.159 5.159m-1.5-1.5 1.409-1.409a2.25 2.25 0 0 1 3.182 0l2.909 2.909m-18 3.75h16.5a1.5 1.5 0 0 0 1.5-1.5V6a1.5 1.5 0 0 0-1.5-1.5H3.75A1.5 1.5 0 0 0 2.25 6v12a1.5 1.5 0 0 0 1.5 1.5Zm10.5-11.25h.008v.008h-.008V8.25Zm.375 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Z"
          />
        </svg>
      </div>
      <div className="to-bg-black-10 absolute inset-0 h-full w-full bg-gradient-to-t from-black/80 via-black/50" />
    </CardHeader>
    <CardBody className="relative py-14 px-6 md:px-12">
        <Typography
          variant="h6"
          color="white"
          className="absolute left-3 bottom-10 h-3 w-44 rounded-full bg-gray-500"
        >
          &nbsp;
        </Typography>
        <Typography
          variant="h6"
          color="white"
          className="absolute left-3 bottom-5 h-3 w-40 rounded-full bg-gray-500"
        >
          &nbsp;
        </Typography>
      </CardBody>
  </Card>

export ShowCard = ({ url, picurl, name }) ->
  <Link to={"/watch?s=#{url}"} className="inline-block">
    <Card
      shadow={false}
      className="relative grid h-[318px] w-[225px] items-end overflow-hidden text-left mr-10"
    >
      <CardHeader
        floated={false}
        shadow={false}
        color="transparent"
        className="absolute inset-0 m-0 h-full w-full rounded-none"
      >
        <img src={picurl} alt={name} className="h-full w-full object-cover" />
        <div className="to-bg-black-10 absolute inset-0 h-full w-full bg-gradient-to-t from-black/80 via-black/50" />
      </CardHeader>
      <CardBody className="relative py-14 px-6 md:px-12">
        <Typography
          variant="h6"
          color="white"
          className="font-bold absolute left-3 bottom-5"
        >
          {name}
        </Typography>
      </CardBody>
    </Card>
  </Link>
