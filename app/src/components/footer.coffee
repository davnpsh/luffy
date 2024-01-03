import { useState, useEffect } from "react"
import { Typography } from "@material-tailwind/react"
import { FaGithub } from "react-icons/fa"
import { useLocation } from 'react-router-dom';

export Footer = ->
  [isContentEnough, setIsContentEnough] = useState false

  location = useLocation()

  useEffect ->
    handleContentHeight()
    window.addEventListener "resize", handleContentHeight
    return -> window.removeEventListener "resize", handleContentHeight
  ,
    [location]

  handleContentHeight = ->
    contentHeight = document.body.clientHeight
    viewportHeight = window.innerHeight

    setIsContentEnough contentHeight >= viewportHeight

  <footer
    className={"bg-ctp-mantle #{
      if isContentEnough then "" else "fixed bottom-0 w-full"
    }"}
  >
    <div className="container m-auto flex w-full flex-row flex-wrap items-center justify-center gap-y-6 gap-x-12 py-6 text-center md:justify-between">
      <Typography color="white" className="font-normal">
        All credits to{" "}
        <a href="https://subsplease.org/" className="font-bold">
          Subsplease
        </a>
      </Typography>
      <Typography color="white" className="font-normal">
        Check this project's repository on
        <a href="https://github.com/davnpsh/luffy">
          &nbsp;<span className="text-2xl">
            <FaGithub style={color: "white", display: "inline-block"} />
          </span>{" "}
          <span className="font-bold">Github</span>
        </a>
      </Typography>
    </div>
  </footer>
