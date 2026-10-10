import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_ps.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa'),
    Locale('ps'),
    Locale('ru'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Tawana Charity & Development Foundation'**
  String get appName;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get navAbout;

  /// No description provided for @navPrograms.
  ///
  /// In en, this message translates to:
  /// **'Programs'**
  String get navPrograms;

  /// No description provided for @navProjects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get navProjects;

  /// No description provided for @navImpact.
  ///
  /// In en, this message translates to:
  /// **'Impact'**
  String get navImpact;

  /// No description provided for @navNews.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get navNews;

  /// No description provided for @navTeam.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get navTeam;

  /// No description provided for @navTransparency.
  ///
  /// In en, this message translates to:
  /// **'Transparency'**
  String get navTransparency;

  /// No description provided for @navGetInvolved.
  ///
  /// In en, this message translates to:
  /// **'Get Involved'**
  String get navGetInvolved;

  /// No description provided for @navContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get navContact;

  /// No description provided for @donate.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get donate;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get learnMore;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get readMore;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @backHome.
  ///
  /// In en, this message translates to:
  /// **'Return home'**
  String get backHome;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get error;

  /// No description provided for @notFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'404 — Page not found'**
  String get notFoundTitle;

  /// No description provided for @notFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'The page you are looking for does not exist.'**
  String get notFoundMessage;

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get statusActive;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @statusUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get statusUpcoming;

  /// No description provided for @labelLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get labelLocation;

  /// No description provided for @labelCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get labelCategory;

  /// No description provided for @labelStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get labelStatus;

  /// No description provided for @labelBeneficiaries.
  ///
  /// In en, this message translates to:
  /// **'Beneficiaries'**
  String get labelBeneficiaries;

  /// No description provided for @labelProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get labelProgress;

  /// No description provided for @labelStartDate.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get labelStartDate;

  /// No description provided for @labelGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get labelGoal;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search projects…'**
  String get searchPlaceholder;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @featuredLabel.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get featuredLabel;

  /// No description provided for @relatedArticles.
  ///
  /// In en, this message translates to:
  /// **'Related articles'**
  String get relatedArticles;

  /// No description provided for @downloadPdf.
  ///
  /// In en, this message translates to:
  /// **'Download PDF'**
  String get downloadPdf;

  /// No description provided for @ourMission.
  ///
  /// In en, this message translates to:
  /// **'Our mission'**
  String get ourMission;

  /// No description provided for @ourVision.
  ///
  /// In en, this message translates to:
  /// **'Our vision'**
  String get ourVision;

  /// No description provided for @ourValues.
  ///
  /// In en, this message translates to:
  /// **'Our values'**
  String get ourValues;

  /// No description provided for @ourStory.
  ///
  /// In en, this message translates to:
  /// **'Our story'**
  String get ourStory;

  /// No description provided for @ourLeadership.
  ///
  /// In en, this message translates to:
  /// **'Our leadership'**
  String get ourLeadership;

  /// No description provided for @ourTimeline.
  ///
  /// In en, this message translates to:
  /// **'Our journey'**
  String get ourTimeline;

  /// No description provided for @footerTagline.
  ///
  /// In en, this message translates to:
  /// **'Working with communities worldwide to build a more hopeful future.'**
  String get footerTagline;

  /// No description provided for @footerAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get footerAbout;

  /// No description provided for @footerOurWork.
  ///
  /// In en, this message translates to:
  /// **'Our work'**
  String get footerOurWork;

  /// No description provided for @footerGetInvolved.
  ///
  /// In en, this message translates to:
  /// **'Get involved'**
  String get footerGetInvolved;

  /// No description provided for @footerTransparency.
  ///
  /// In en, this message translates to:
  /// **'Transparency'**
  String get footerTransparency;

  /// No description provided for @footerContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get footerContact;

  /// No description provided for @footerPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get footerPrivacy;

  /// No description provided for @footerTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get footerTerms;

  /// No description provided for @footerRights.
  ///
  /// In en, this message translates to:
  /// **'All rights reserved.'**
  String get footerRights;

  /// No description provided for @heroTitle.
  ///
  /// In en, this message translates to:
  /// **'Together, we create a better future'**
  String get heroTitle;

  /// No description provided for @heroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Supporting communities, empowering people, and creating sustainable change.'**
  String get heroSubtitle;

  /// No description provided for @heroCTA1.
  ///
  /// In en, this message translates to:
  /// **'Support our mission'**
  String get heroCTA1;

  /// No description provided for @heroCTA2.
  ///
  /// In en, this message translates to:
  /// **'Explore our work'**
  String get heroCTA2;

  /// No description provided for @homeImpactTitle.
  ///
  /// In en, this message translates to:
  /// **'Our impact so far'**
  String get homeImpactTitle;

  /// No description provided for @homeImpactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Every number represents a person, a family, a community.'**
  String get homeImpactSubtitle;

  /// No description provided for @homeMissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Who we are'**
  String get homeMissionTitle;

  /// No description provided for @homeProjectsTitle.
  ///
  /// In en, this message translates to:
  /// **'Featured projects'**
  String get homeProjectsTitle;

  /// No description provided for @homeProjectsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A selection of the work we do around the world.'**
  String get homeProjectsSubtitle;

  /// No description provided for @homeAreasTitle.
  ///
  /// In en, this message translates to:
  /// **'Areas of work'**
  String get homeAreasTitle;

  /// No description provided for @homeStoryTitle.
  ///
  /// In en, this message translates to:
  /// **'A story of change'**
  String get homeStoryTitle;

  /// No description provided for @homeNewsTitle.
  ///
  /// In en, this message translates to:
  /// **'Latest news'**
  String get homeNewsTitle;

  /// No description provided for @homeNewsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Stories and updates from the field.'**
  String get homeNewsSubtitle;

  /// No description provided for @homeCTA_Title.
  ///
  /// In en, this message translates to:
  /// **'Change begins with people like you'**
  String get homeCTA_Title;

  /// No description provided for @homeCTA_Text.
  ///
  /// In en, this message translates to:
  /// **'Your support makes our work possible.'**
  String get homeCTA_Text;

  /// No description provided for @homeCTA_Donate.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get homeCTA_Donate;

  /// No description provided for @homeCTA_Volunteer.
  ///
  /// In en, this message translates to:
  /// **'Volunteer'**
  String get homeCTA_Volunteer;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get aboutTitle;

  /// No description provided for @aboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A foundation built on trust, transparency and long-term commitment.'**
  String get aboutSubtitle;

  /// No description provided for @aboutHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Our history'**
  String get aboutHistoryTitle;

  /// No description provided for @aboutCountriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Where we work'**
  String get aboutCountriesTitle;

  /// No description provided for @programsTitle.
  ///
  /// In en, this message translates to:
  /// **'Programs'**
  String get programsTitle;

  /// No description provided for @programsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The main areas of work of the foundation.'**
  String get programsSubtitle;

  /// No description provided for @programObjectives.
  ///
  /// In en, this message translates to:
  /// **'Objectives'**
  String get programObjectives;

  /// No description provided for @programImpact.
  ///
  /// In en, this message translates to:
  /// **'Impact'**
  String get programImpact;

  /// No description provided for @programRelated.
  ///
  /// In en, this message translates to:
  /// **'Related projects'**
  String get programRelated;

  /// No description provided for @projectsTitle.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projectsTitle;

  /// No description provided for @projectsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore our current and completed work.'**
  String get projectsSubtitle;

  /// No description provided for @impactTitle.
  ///
  /// In en, this message translates to:
  /// **'Impact'**
  String get impactTitle;

  /// No description provided for @impactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Measurable results and the people behind them.'**
  String get impactSubtitle;

  /// No description provided for @impactStatProjects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get impactStatProjects;

  /// No description provided for @impactStatPeople.
  ///
  /// In en, this message translates to:
  /// **'People supported'**
  String get impactStatPeople;

  /// No description provided for @impactStatCommunities.
  ///
  /// In en, this message translates to:
  /// **'Communities'**
  String get impactStatCommunities;

  /// No description provided for @impactStatCountries.
  ///
  /// In en, this message translates to:
  /// **'Countries'**
  String get impactStatCountries;

  /// No description provided for @impactStatVolunteers.
  ///
  /// In en, this message translates to:
  /// **'Volunteers'**
  String get impactStatVolunteers;

  /// No description provided for @impactStories.
  ///
  /// In en, this message translates to:
  /// **'Success stories'**
  String get impactStories;

  /// No description provided for @newsTitle.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get newsTitle;

  /// No description provided for @newsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Updates from the field.'**
  String get newsSubtitle;

  /// No description provided for @teamTitle.
  ///
  /// In en, this message translates to:
  /// **'Our team'**
  String get teamTitle;

  /// No description provided for @teamSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The people behind the foundation.'**
  String get teamSubtitle;

  /// No description provided for @teamLeadership.
  ///
  /// In en, this message translates to:
  /// **'Leadership'**
  String get teamLeadership;

  /// No description provided for @teamStaff.
  ///
  /// In en, this message translates to:
  /// **'Staff'**
  String get teamStaff;

  /// No description provided for @teamAdvisors.
  ///
  /// In en, this message translates to:
  /// **'Advisors'**
  String get teamAdvisors;

  /// No description provided for @transparencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Transparency'**
  String get transparencyTitle;

  /// No description provided for @transparencySubtitle.
  ///
  /// In en, this message translates to:
  /// **'We are accountable to the people we serve and to our supporters.'**
  String get transparencySubtitle;

  /// No description provided for @transparencyFinancial.
  ///
  /// In en, this message translates to:
  /// **'Financial transparency'**
  String get transparencyFinancial;

  /// No description provided for @transparencyReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get transparencyReports;

  /// No description provided for @transparencyGovernance.
  ///
  /// In en, this message translates to:
  /// **'Governance'**
  String get transparencyGovernance;

  /// No description provided for @involvedTitle.
  ///
  /// In en, this message translates to:
  /// **'Get involved'**
  String get involvedTitle;

  /// No description provided for @involvedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'There are many ways to support our work.'**
  String get involvedSubtitle;

  /// No description provided for @involvedVolunteer.
  ///
  /// In en, this message translates to:
  /// **'Volunteer'**
  String get involvedVolunteer;

  /// No description provided for @involvedVolunteerText.
  ///
  /// In en, this message translates to:
  /// **'Give your time and skills to projects that matter.'**
  String get involvedVolunteerText;

  /// No description provided for @involvedPartner.
  ///
  /// In en, this message translates to:
  /// **'Partner with us'**
  String get involvedPartner;

  /// No description provided for @involvedPartnerText.
  ///
  /// In en, this message translates to:
  /// **'Collaborate on programs that create lasting change.'**
  String get involvedPartnerText;

  /// No description provided for @involvedFundraise.
  ///
  /// In en, this message translates to:
  /// **'Fundraise'**
  String get involvedFundraise;

  /// No description provided for @involvedFundraiseText.
  ///
  /// In en, this message translates to:
  /// **'Start a campaign in your community.'**
  String get involvedFundraiseText;

  /// No description provided for @involvedCorporate.
  ///
  /// In en, this message translates to:
  /// **'Corporate partnership'**
  String get involvedCorporate;

  /// No description provided for @involvedCorporateText.
  ///
  /// In en, this message translates to:
  /// **'Align your company with a meaningful cause.'**
  String get involvedCorporateText;

  /// No description provided for @involvedAmbassador.
  ///
  /// In en, this message translates to:
  /// **'Become an ambassador'**
  String get involvedAmbassador;

  /// No description provided for @involvedAmbassadorText.
  ///
  /// In en, this message translates to:
  /// **'Represent the foundation in your region.'**
  String get involvedAmbassadorText;

  /// No description provided for @donateTitle.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get donateTitle;

  /// No description provided for @donateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your gift supports communities in need.'**
  String get donateSubtitle;

  /// No description provided for @donateWhy.
  ///
  /// In en, this message translates to:
  /// **'Why donate'**
  String get donateWhy;

  /// No description provided for @donateWhere.
  ///
  /// In en, this message translates to:
  /// **'Where your donation goes'**
  String get donateWhere;

  /// No description provided for @donateOptions.
  ///
  /// In en, this message translates to:
  /// **'Donation options'**
  String get donateOptions;

  /// No description provided for @donateBank.
  ///
  /// In en, this message translates to:
  /// **'Bank transfer'**
  String get donateBank;

  /// No description provided for @donateFAQ.
  ///
  /// In en, this message translates to:
  /// **'Frequently asked questions'**
  String get donateFAQ;

  /// No description provided for @donateFutureNote.
  ///
  /// In en, this message translates to:
  /// **'Online payment will be available soon. For now, please use bank transfer or contact us directly.'**
  String get donateFutureNote;

  /// No description provided for @contactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contactTitle;

  /// No description provided for @contactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We would love to hear from you.'**
  String get contactSubtitle;

  /// No description provided for @contactAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get contactAddress;

  /// No description provided for @contactEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get contactEmail;

  /// No description provided for @contactPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get contactPhone;

  /// No description provided for @contactHours.
  ///
  /// In en, this message translates to:
  /// **'Office hours'**
  String get contactHours;

  /// No description provided for @contactFollow.
  ///
  /// In en, this message translates to:
  /// **'Follow us'**
  String get contactFollow;

  /// No description provided for @contactFormName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get contactFormName;

  /// No description provided for @contactFormEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get contactFormEmail;

  /// No description provided for @contactFormPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get contactFormPhone;

  /// No description provided for @contactFormSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get contactFormSubject;

  /// No description provided for @contactFormMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get contactFormMessage;

  /// No description provided for @contactFormSend.
  ///
  /// In en, this message translates to:
  /// **'Send message'**
  String get contactFormSend;

  /// No description provided for @contactFormSuccess.
  ///
  /// In en, this message translates to:
  /// **'Thank you for contacting us. Online submission will be available soon.'**
  String get contactFormSuccess;

  /// No description provided for @projectsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No projects match your search or filter.'**
  String get projectsEmpty;

  /// No description provided for @newsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No news has been published yet.'**
  String get newsEmpty;

  /// No description provided for @projectNotFound.
  ///
  /// In en, this message translates to:
  /// **'This project could not be found.'**
  String get projectNotFound;

  /// No description provided for @articleNotFound.
  ///
  /// In en, this message translates to:
  /// **'This article could not be found.'**
  String get articleNotFound;

  /// No description provided for @projectOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get projectOverview;

  /// No description provided for @projectChallenge.
  ///
  /// In en, this message translates to:
  /// **'The challenge'**
  String get projectChallenge;

  /// No description provided for @projectApproach.
  ///
  /// In en, this message translates to:
  /// **'Our approach'**
  String get projectApproach;

  /// No description provided for @projectResults.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get projectResults;

  /// No description provided for @formRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get formRequired;

  /// No description provided for @formInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get formInvalidEmail;

  /// No description provided for @transparencyFinancialText.
  ///
  /// In en, this message translates to:
  /// **'87% of funds go directly to programs, 8% to operations and 5% to fundraising. Full details are available in the annual reports below.'**
  String get transparencyFinancialText;

  /// No description provided for @transparencyGovernanceText.
  ///
  /// In en, this message translates to:
  /// **'Registered as a non-profit organization. Governance is provided by an independent board. Policies are available on request.'**
  String get transparencyGovernanceText;

  /// No description provided for @reportUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This report will be available for download soon.'**
  String get reportUnavailable;

  /// No description provided for @donateWhyText.
  ///
  /// In en, this message translates to:
  /// **'Your gift provides education, healthcare and emergency relief to families who need it most.'**
  String get donateWhyText;

  /// No description provided for @donateWhereText.
  ///
  /// In en, this message translates to:
  /// **'87% of every donation goes directly to programs. 8% covers operations and 5% fundraising.'**
  String get donateWhereText;

  /// No description provided for @donateOptionsText.
  ///
  /// In en, this message translates to:
  /// **'One-time gifts · Monthly giving · In-kind donations · Corporate matching'**
  String get donateOptionsText;

  /// No description provided for @donateBankLabel.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get donateBankLabel;

  /// No description provided for @donateAccountLabel.
  ///
  /// In en, this message translates to:
  /// **'Account name'**
  String get donateAccountLabel;

  /// No description provided for @donateReferenceLabel.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get donateReferenceLabel;

  /// No description provided for @donateReferenceValue.
  ///
  /// In en, this message translates to:
  /// **'Donation'**
  String get donateReferenceValue;

  /// No description provided for @donateFaq1Q.
  ///
  /// In en, this message translates to:
  /// **'Is my donation tax-deductible?'**
  String get donateFaq1Q;

  /// No description provided for @donateFaq1A.
  ///
  /// In en, this message translates to:
  /// **'Yes, in jurisdictions where the foundation is registered. Contact us for details.'**
  String get donateFaq1A;

  /// No description provided for @donateFaq2Q.
  ///
  /// In en, this message translates to:
  /// **'Can I cancel a monthly gift?'**
  String get donateFaq2Q;

  /// No description provided for @donateFaq2A.
  ///
  /// In en, this message translates to:
  /// **'Yes, at any time. Just contact our office.'**
  String get donateFaq2A;

  /// No description provided for @donateFaq3Q.
  ///
  /// In en, this message translates to:
  /// **'How do I know my donation is used well?'**
  String get donateFaq3Q;

  /// No description provided for @donateFaq3A.
  ///
  /// In en, this message translates to:
  /// **'See our Transparency page for full financial reports.'**
  String get donateFaq3A;

  /// No description provided for @contactHoursValue.
  ///
  /// In en, this message translates to:
  /// **'Mon–Fri, 9:00–17:00'**
  String get contactHoursValue;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa', 'ps', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
    case 'ps':
      return AppLocalizationsPs();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
