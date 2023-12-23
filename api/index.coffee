import { getSchedule, getShowEpisodes } from "./scrapper.coffee"

episodes = await getShowEpisodes "https://subsplease.org/shows/shy/"