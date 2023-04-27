import React, { useCallback, useMemo, useState } from "react";
import { registerComponent, Components } from "../../../lib/vulcan-lib";
import DialogContent from "@material-ui/core/DialogContent";
import DialogTitle from "@material-ui/core/DialogTitle";
import Checkbox from "@material-ui/core/Checkbox";
import classNames from "classnames";
import Button from "@material-ui/core/Button";
import { CookieType, CookiesTable, isValidCookieTypeArray } from "../../../lib/cookies/utils";
import { useUpdateCookiePreferences } from "../../hooks/useCookiesWithConsent";
import { COOKIE_PREFERENCES_COOKIE } from "../../../lib/cookies/cookies";

const styles = (theme: ThemeType) => ({
  dialog: {
    margin: 24,
  },
  title: {
    marginLeft: 4,
    padding: "24px 24px 10px",
    color: "white",
  },
  content: {
    minWidth: 280,
  },
  blurb: {
    marginLeft: 4,
    marginRight: 4,
    marginBottom: 12,
    "& a": {
      textDecoration: "underline",
      fontWeight: 600,
      "&:hover": {
        textDecoration: "underline",
      },
    },
  },
  categoryWrapper: {
    marginBottom: 8,
  },
  category: {
    height: 48,
    display: "flex",
    alignItems: "center",
    justifyContent: "space-between",
    backgroundColor: theme.palette.grey[100],
    borderRadius: theme.borderRadius.default,
  },
  categoryLabel: {
    paddingLeft: 6,
    display: "flex",
    flexDirection: "row",
    alignItems: "center",
    cursor: "pointer",
  },
  checkboxOrLabel: {
    padding: 12,
  },
  explanationContainer: {
    maxHeight: 0,
    overflow: "hidden",
    transition: "max-height 0.3s ease-in-out",
  },
  explanation: {
    padding: '8px 0px',
    fontWeight: 400,
  },
  open: {
    maxHeight: "200px",
    overflow: "auto",
  },
  button: {
    marginTop: 12,
    marginLeft: "auto",
    color: theme.palette.text.alwaysWhite,
    textTransform: "none",
    whiteSpace: "nowrap",
    fontSize: 14,
    display: "block",
  },
});

const CookieCategory = ({
  title,
  cookieType,
  allowedCookies,
  setAllowedCookies,
  alwaysEnabled = false,
  className,
  classes,
}: {
  title: string;
  cookieType: CookieType;
  allowedCookies: CookieType[];
  setAllowedCookies: (cookies: CookieType[]) => void;
  alwaysEnabled?: boolean;
  className?: string;
  classes: ClassesType;
}) => {
  const { Typography, ForumIcon, CookieTable } = Components;
  const [open, setOpen] = useState(false);

  const checked = useMemo(() => allowedCookies.includes(cookieType), [allowedCookies, cookieType]);
  const toggleCookie = useCallback(() => {
    if (alwaysEnabled) return;
    if (checked) {
      setAllowedCookies(allowedCookies.filter((c) => c !== cookieType));
    } else {
      setAllowedCookies([...allowedCookies, cookieType]);
    }
  }, [alwaysEnabled, checked, setAllowedCookies, allowedCookies, cookieType]);

  const cookieTypeExplanations: Record<CookieType, string> = {
    necessary: "Necessary cookies are essential for the website to function properly. These cookies ensure basic functionalities and security features of the website, anonymously. In general these cookies expire after 24 months.",
    functional: "Functional cookies help to perform certain functionalities like remembering whether certain banners are hidden, or allowing you to contact us via Intercom. In general these cookies expire after 24 months.",
    analytics: "Analytics cookies are used to understand how visitors interact with the website. These cookies help provide information on metrics the number of visitors, bounce rate, traffic source, etc. In general these cookies expire after 24 months.",
  }
  const explanation = cookieTypeExplanations[cookieType];

  const uniqueThirdPartyNames = [...new Set(Object.values(CookiesTable).filter(cookie => cookie.type === cookieType).map(cookie => cookie.thirdPartyName))].sort().reverse();

  return (
    <div className={className}>
      <div className={classes.category}>
        <div className={classes.categoryLabel} onClick={() => setOpen(!open)}>
          <ForumIcon icon={open ? "ThickChevronDown" : "ThickChevronRight"} />
          <Typography variant="body2" className={classes.categoryTitle}>
            {title}
          </Typography>
        </div>
        {alwaysEnabled ? (
          <Typography variant="body2" className={classes.checkboxOrLabel}>
            <i>always enabled</i>
          </Typography>
        ) : (
          <Checkbox className={classes.checkboxOrLabel} checked={checked} onChange={toggleCookie} />
        )}
      </div>
      <div
        className={classNames(classes.explanationContainer, {
          [classes.open]: open,
        })}
      >
        <Typography variant="body2" className={classes.explanation}>
          {explanation}
        </Typography>
        {uniqueThirdPartyNames.map((name) => <CookieTable type={cookieType} thirdPartyName={name} key={`${cookieType}_${name}`}/>)}
      </div>
    </div>
  );
};

const CookieDialog = ({ onClose, classes }: { onClose?: () => void; classes: ClassesType }) => {
  const { LWDialog, Typography } = Components;

  const [cookies, updateCookiePreferences] = useUpdateCookiePreferences();
  const existingCookiePreferences = isValidCookieTypeArray(cookies[COOKIE_PREFERENCES_COOKIE])
    ? cookies[COOKIE_PREFERENCES_COOKIE]
    : ["necessary"];
  const [allowedCookies, setAllowedCookies] = useState<CookieType[]>(existingCookiePreferences);

  const saveAndClose = useCallback(() => {
    updateCookiePreferences(allowedCookies);
    onClose?.();
  }, [allowedCookies, onClose, updateCookiePreferences]);

  return (
    <LWDialog open onClose={onClose} dialogClasses={{
      paper: classes.dialog,
    }}>
      <DialogTitle className={classes.title}>Cookie Settings</DialogTitle>
      <DialogContent className={classes.content}>
        <Typography variant="body2" className={classes.blurb}>
          We use cookies to improve your experience while you navigate through the website. Necessary cookies are always
          stored in your browser as they are essential for the basic functionality of the website. We also use cookies
          for non-essential purposes such as remembering your preferences between visits, or for analytics. These
          cookies will be stored in your browser only with your consent. Read our full cookie policy{" "}
          <a href="/cookiePolicy">here</a>.
        </Typography>
        <CookieCategory
          title="Necessary"
          cookieType="necessary"
          allowedCookies={allowedCookies}
          setAllowedCookies={setAllowedCookies}
          alwaysEnabled
          classes={classes}
          className={classes.categoryWrapper}
        />
        <CookieCategory
          title="Functional"
          cookieType="functional"
          allowedCookies={allowedCookies}
          setAllowedCookies={setAllowedCookies}
          classes={classes}
          className={classes.categoryWrapper}
        />
        <CookieCategory
          title="Analytics"
          cookieType="analytics"
          allowedCookies={allowedCookies}
          setAllowedCookies={setAllowedCookies}
          classes={classes}
          className={classes.categoryWrapper}
        />
        <Button className={classes.button} variant="contained" color="primary" onClick={saveAndClose}>
          Save preferences
        </Button>
      </DialogContent>
    </LWDialog>
  );
};

const CookieDialogComponent = registerComponent("CookieDialog", CookieDialog, {
  styles,
});

declare global {
  interface ComponentTypes {
    CookieDialog: typeof CookieDialogComponent;
  }
}
