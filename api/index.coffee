import { getShowID, getShowDetails, getEpisodeDetails } from "./src/tmdb.coffee"

showID = await getShowID "SHY", "2023"
episodeDetails = await getEpisodeDetails showID, "1", "1"

console.log episodeDetails