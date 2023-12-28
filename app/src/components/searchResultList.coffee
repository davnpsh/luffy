import {
  List
  ListItem
  ListItemPrefix
  Card
  Typography
} from "@material-tailwind/react"

export SearchResultListSkeleton = ->
  <Card className="w-72 absolute">
    <List>
      {Array 3
        .fill()
        .map (_, index) ->
          <ListItem>
            <ListItemPrefix>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth={2}
                stroke="currentColor"
                className="h-12 w-12 text-gray-300 animate-pulse"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="m2.25 15.75 5.159-5.159a2.25 2.25 0 0 1 3.182 0l5.159 5.159m-1.5-1.5 1.409-1.409a2.25 2.25 0 0 1 3.182 0l2.909 2.909m-18 3.75h16.5a1.5 1.5 0 0 0 1.5-1.5V6a1.5 1.5 0 0 0-1.5-1.5H3.75A1.5 1.5 0 0 0 2.25 6v12a1.5 1.5 0 0 0 1.5 1.5Zm10.5-11.25h.008v.008h-.008V8.25Zm.375 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Z"
                />
              </svg>
            </ListItemPrefix>
            <div className="animate-pulse">
              <Typography
                as="div"
                variant="h1"
                className="mb-4 h-3 w-44 rounded-full bg-gray-300"
              >
                &nbsp;
              </Typography>
            </div>
          </ListItem>
        }
    </List>
  </Card>
