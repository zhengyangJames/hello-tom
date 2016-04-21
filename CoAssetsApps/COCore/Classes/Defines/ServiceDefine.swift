//
//  ServiceDefine.swift
//  CoAssetsApps
//
//  Created by Linh NGUYEN on 3/2/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class ServiceDefine: NSObject {
    
    enum Method {
        static let RegisterUser                 = "/profile/register/"
        static let GetCompanyInfo               = "/company_info"
        static let PostDeviceToken              = "/create-notification-device/"
        static let GetInvestmentDashboard       = "/investment_dashboard/"
        static let ForgetPassword               = "/forget-password/"
        static let ChangePassword               = "/change-password/"
        static let GetListNotification          = "/get-notification-list/"
        static let ReadNotification             = "/read-notification/"
        //Offer
        static let GetListOffer                 = "/offers/"
        static let ProjectFullInfo              = "/project_fund_info/"
        static let PostSubcribe                 = "/offers/subscribe/"
        static let PostQuestion                 = "/offers/tellmemore/"
        //Profile
        static let GetInvestorProfile           = "/investment_profile/"
        static let GetProfile                   = "/profile/"
        static let GetProfileWithdrawal         = "/profile/get_completed_withdrawal/"
        //Notification
        static let GetInvestorDeal              = "/investor_deal_list/"
        static let CompanyProfile               = "/profile_organization/"
        static let GetStockPrice                = "/stock-price/"
        static let PostStockBuyShared           = "/buy-share/"
        static let ProtfolioWithdrawal          = "/profile/get_completed_withdrawal/"
        static let ProtfolioGetAllBalance       = "/profile/get_balance_all/"
        static let ProtfolioPostAllBalance      = "/profile/withdraw/"
    }
    
    enum StaticURL {
        static let News                 = "http://coassets.com/news/apps/"
        static let TermsOfUse           = "http://www.coassets.com/apps/terms-of-use/"
        static let CodeOfConduct        = "http://www.coassets.com/apps/code-of-conduct/"
        static let Privacy              = "http://www.coassets.com/apps/privacy/"
    }
    
    enum Domain {
        static let ErrorDomain          = "WS_ERROR_DOMAIN"
    }

}

//MARK: - Key Token
extension ServiceDefine {
    
    enum HeadersKey {
        static let Authorization             = "Authorization"
        static let HeadersContenType         = "content_type"
    }
    
    enum NotificationKey {
        static let ContentType          = "application/x-www-form-urlencoded"
        static let ApplicationNameGet   = "appx"
        static let ApplicationNamePost  = "aapx"
        static let DeviceType           = "ios"
        static let ClientKey            = "aapx-ios-6789"
        static let NotificationStatus   = "notification_status"
        static let NotificationId       = "notification_id"
        static let DeviceToken          = "device_token"
    }
    
}

//MARK: - Field
extension ServiceDefine {
    
    enum OfferField {
        static let OfferID              = "offer_id"
        static let Amount               = "amount"
        static let Message              = "message"
        static let Question             = "question"
    }
    
    enum OAuth2Field {
        static let ClientId             = "client_id"
        static let ClientSecret         = "client_secret"
        static let GrantType            = "grant_type"
        static let RefreshToken         = "refresh_token"
    }
    
    enum UserField {
        static let UserName             = "username"
        static let Password             = "password"
        static let NewPassword          = "new_password"
        static let Email                = "email"
        static let ApplicationName      = "application_name"
        static let ClientKey            = "client_key"
        static let DeviceType           = "device_type"
        static let FirstName            = "first_name"
        static let LastName             = "last_name"
        static let CountryCode          = "country_prefix"
        static let CellPhone            = "cellphone"
    }
    
    enum OfferObjectField {
        static let Currency             = "currency"
        static let OfferId              = "id"
        static let Interested           = "interested"
        static let IsPremiumListing     = "is_premium_listing"
        static let MaxAnnualReturn      = "max_annual_return"
        static let MinAnnualReturn      = "min_annual_return"
        static let MinInvestment        = "min_investment"
        static let OfferTitle           = "offer_title"
        static let OfferType            = "offer_type"
        static let OwnerType            = "owner_type"
        static let ShortDescription     = "short_description"
        static let TokensPerFancy       = "tokens_per_fancy"
        static let Project              = "project"
        
        static let CompanyLogo          = "company_logo"
        static let DeveloperDescription = "developerDescription"
        static let Status               = "status"
        static let InvestorCount        = "investor_count"
        static let DeveloperName        = "developer_name"
        static let HowToCrowdFundPic    = "how_to_crowd_fund_pic"
        static let Documents            = "documents"
        static let projectDescription   = "project_description"
        static let dayLeft              = "day_left"
        static let timeHorizon          = "time_horizon"
        static let annualizedReturn     = "annualized_return"
        static let annualReturn         = "annual_return"
        
        static let pledged              = "pledged"
        static let percentFunded        = "percent_funded"
    }
    enum ProjectObjectField {
        static let Address1             = "address_1"
        static let Address2             = "address_2"
        static let City                 = "city"
        static let Country              = "country"
        static let Developer            = "developer"
        static let ProjectId            = "id"
        static let Name                 = "name"
        static let Photo                = "photo"
        static let ProjectType          = "project_type"
        static let StateRegion          = "state_region"
    }
    
    enum UserProfileField {
        static let Email                = "email"
        static let LastName             = "last_name"
        static let Tokens               = "tokens"
        static let FirstName            = "first_name"
        static let UserName             = "username"
        static let UserProfileId        = "id"
        static let Account              = "account"
        static let Profile              = "profile"
    }
    
    enum UserProfileDetailField {
        static let PostalCode           = "postal_code"
        static let CountryPrefix        = "country_prefix"
        static let RegionState          = "region_state"
        static let Country              = "country"
        static let City                 = "city"
        static let ProfileDetailId      = "id"
        static let Address1             = "address_1"
        static let Address2             = "address_2"
        static let CellPhone            = "cellphone"
    }
    
    enum UserProfileAccountField {
        static let AccountExpiry        = "account_expiry"
        static let AccountType          = "account_type"
    }
    
    enum UserProfileTokensField {
        static let CreditQty            = "credit_qty"
        static let ProfileTokensId      = "id"
    }
    
    enum UserProfileInvestorField {
        static let InvestorType         = "investor_type"
        static let project              = "project_type"
        static let countries            = "preferred_country_list"
        static let country              = "country"
        static let duration             = "duration_preference_in_month"
        static let target               = "target_annualize_return"
        static let investment           = "investment_budget"
        static let CurrencyPreference   = "currency_preference"
        static let descriptions         = "description"
        static let website              = "website"
        static let investmentBudget     = "investment_budget"
        static let ProjectList          = "project_type_list"
        static let InvestList           = "investor_type_list"
        static let CurrenceList         = "currency_list"
    }
    
    enum CompanyProfileField {
        static let OrgName              = "org_name"
        static let OrgType              = "org_type"
        static let HeightImageProfile   = "height_image_profile"
        static let OrgCountry           = "country"
        static let Address1             = "address_1"
        static let Address2             = "address_2"
        static let LogoUrl              = "logo"
        static let OrgCity              = "city"
    }
    
    enum StockProfileField {
        static let Code                 = "code"
        static let Currency             = "currency"
        static let Price                = "price"
        static let PriceDate            = "price_date"
    }
    
    enum InvestorDealField {
        static let Funded       = "funded"
        static let Completed    = "completed"
        static let Ongoing      = "ongoing"
    }
    
    enum InvestorDealDetailField {
        static let DealOngoingNextPayoutDate         = "next_payout_date"
        static let DealOngoingCurrency               = "currency"
        static let DealOngoingInvestAmount           = "invest_amount"
        static let DealOngoingNextPayoutAmount       = "next_payout_amount"
        static let DealOngoingPotentialReturnAmount  = "potential_return_amount"
        static let DealOngoingPotentialReturnPercent = "potential_return_percent"
        static let DealOngoingProjectName            = "project_name"
        static let DealOngoingStatus                 = "status"
        static let DealOngoingPaymentInstruction     = "payment_instruction"
        static let DealOngoingContractInstruction    = "sign_contract_instruction"
    }
    
    enum InvestorDetailStatusField {
        static let DealOngoingStatusIsPaid           = "is_paid"
        static let DealOngoingStatusIsSigned         = "is_signed"
    }
    
    enum InvestmentDashboardField {
        static let OngoingInvestment    = "commit"
        static let FundedInvestment     = "funded_invested_amt"
        static let CompletedInvestment  = "completed_invested_amt"
        static let RealisedPayouts      = "total_paid_payout"
        static let PotentialPayouts     = "total_unpaid_payout"
        static let UserPortfolio        = "portfolio"
        static let CustomMessage        = "custom_message"
    }
    
    enum PortfolioBalanceField {
        static let BalanceAmt           = "balance_amt"
        static let Currency             = "currency"
        static let Updated              = "updated"
        static let amount               = "amount"
    }
    
    enum PortfolioCompleteField {
        static let Key                  = "key"
        static let Value                = "value"
    }
    
    enum MultiPortfolioField {
        static let OngoingInvestment    = "ongoing_investment"
        static let CompleteInvestment   = "funded_and_completed_investment"
        static let OngoingProject       = "ongoing_projects"
        static let CompleteProject      = "funded_and_completed_projects"
        static let CurrencyMultiPort    = "multiple_currency_portfolio"
    }
    
    enum CurrencyInvestment {
        static let Currency             = "currency"
        static let Amount               = "amount"
    }
}

//MARK: - ErrorMessage
extension ServiceDefine {
    
    enum ErrorMessage {
        static let DeviceTokenExit      = "device already exist."
        static let DeviceTockenInvalid  = "Invalid device token."
        static let DeviceTockenCreated  = "device successfully created."
    }
}

extension ServiceDefine {
    enum InvestorListType: Int {
        case TypeInvestor = 0
        case TypeCurrency = 1
        case TypeProject = 2
    }
}

//MARK: SettingContact
extension ServiceDefine {
    enum ContactField {
        static let RegNo = "reg_no"
        static let City = "city"
        static let PostalCode = "postal_code"
        static let Country = "country"
        static let Add2 = "add_2"
        static let PhoneNo = "phone_no"
        static let Add1 = "add_1"
        static let Name = "name"
    }
}

//MARK:
extension ServiceDefine {
    enum NotificationField {
        static let Data = "data"
        static let Alert = "alert"
        static let Status = "status"
        static let Type = "type"
        static let IdKey = "id"
        static let Url = "url"
        static let DateTimeCreated = "date_time_created"
        static let UniqueId = "unique_id"
    }
}

extension ServiceDefine {
    enum DocumentField {
        static let LegalAppointment = "legal_appointment"
        static let Ownership = "ownership"
        static let Licenses = "licenses"
        static let RegistrationFormList = "registration_form_list"
        static let DeclarationFormList = "declaration_form_list"
        static let Others = "others"
        static let Url = "url"
        static let Title = "title"
    }
}

extension ServiceDefine {
    enum ProjectFunInfoField {
        static let CurrentFundedAmount = "current_funded_amount"
        static let DayLeft = "day_left"
        static let Goal = "goal"
        static let NeededAmount = "needed_amount"
    }
}
