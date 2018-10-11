import createLWTheme from './createThemeDefaults.js';
import grey from '@material-ui/core/colors/grey';
import deepOrange from '@material-ui/core/colors/deepOrange';

const sansSerifStack = [
  'warnock-pro',
  'Calibri',
  '"Gill Sans"',
  '"Gill Sans MT"',
  "Myriad Pro",
  'Myriad',
  '"DejaVu Sans Condensed"',
  '"Liberation Sans"',
  '"Nimbus Sans L"',
  'Tahoma',
  'Geneva',
  '"Helvetica Neue"',
  'Helvetica',
  'Arial',
  'sans-serif'
].join(',')

const serifStack = [
  'ETBembo',
  'warnock-pro',
  'Palatino',
  '"Palatino Linotype"',
  '"Palatino LT STD"',
  '"Book Antiqua"',
  'Georgia',
  'serif'
].join(',')

const palette = {
  primary: {
    main: '#5f9b65',
  },
  secondary: {
    main: '#5f9b65',
  },
  error: {
    main: deepOrange[900]
  },
  background: {
    default: '#fff'
  }
}

const theme = createLWTheme({
  palette: palette,
  typography: {
    fontDownloads: [
      "https://fonts.googleapis.com/css?family=Cardo:400,400i,700"
    ],
    fontFamily: sansSerifStack,
    postStyle: {
      fontFamily: serifStack,
      linkUnderlinePosition: "72%",
    },
    headerStyle: {
      fontFamily: serifStack,
      linkUnderlinePosition: "72%",
    },
    body2: {
      fontSize: "1.16rem"
    },
    commentStyle: {
      fontFamily: sansSerifStack
    },
    headline: {
      fontFamily: serifStack,
    },
    subheading: {
      fontFamily: serifStack,
    },
    title: {
      fontFamily: serifStack,
      fontWeight: 500,
    }
  },
  overrides: {
    MuiAppBar: {
      colorDefault: {
        backgroundColor: grey[50],
      }
    },
    PostsVote: {
      voteScores: {
        margin: "25% 15% 15% 15%"
      }
    },
    MuiTooltip: {
      tooltip: {
        fontSize: "1rem"
      }
    }
  }
});

export default theme
