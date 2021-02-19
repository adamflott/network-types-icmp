{-|
Module      : Network.Types.ICMP
Description : Data types for ICMP types and codes
Copyright   : (c) 2021 Adam Flott
License     : BSD-3-Clause
Maintainer  : adam@adamflott.com
Stability   : experimental
Portability : POSIX

Data types and conversions for ICMP automatically built from the specification at
<https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xml>


Specification date: 2020-09-25
-}
module Network.Types.ICMP (
    -- * Types
    ICMPType(..)

    -- * Codes
    , ICMPCodeNum(..)
    , ICMPCode(..)

    -- * Codes from Type
    , icmpCodesForType

    -- * Conversions
    , icmpTypeToStringNum
    , icmpTypeFromStringNum
    , icmpTypeToNum

    -- * Deprecated testing
    , isICMPTypeDeprecated

) where


-- base
import Data.String (IsString)
import Data.Word (Word8)
import GHC.Generics

-- | Wrap a numeric ICMP type.
--
-- @since 1.0.0.0
newtype ICMPTypeNum = ICMPTypeNum Word8


-- | ICMP type.
--
-- @since 1.0.0.0
data ICMPType
    = ICMPTypeUnknown
    | ICMPType0EchoReply -- ^ Echo Reply
    | ICMPType3DestinationUnreachable -- ^ Destination Unreachable
    | ICMPType4SourceQuenchDeprecated -- ^ Source Quench (Deprecated)
    | ICMPType5Redirect -- ^ Redirect
    | ICMPType6AlternateHostAddressDeprecated -- ^ Alternate Host Address (Deprecated)
    | ICMPType8Echo -- ^ Echo
    | ICMPType9RouterAdvertisement -- ^ Router Advertisement
    | ICMPType10RouterSolicitation -- ^ Router Solicitation
    | ICMPType11TimeExceeded -- ^ Time Exceeded
    | ICMPType12ParameterProblem -- ^ Parameter Problem
    | ICMPType13Timestamp -- ^ Timestamp
    | ICMPType14TimestampReply -- ^ Timestamp Reply
    | ICMPType15InformationRequestDeprecated -- ^ Information Request (Deprecated)
    | ICMPType16InformationReplyDeprecated -- ^ Information Reply (Deprecated)
    | ICMPType17AddressMaskRequestDeprecated -- ^ Address Mask Request (Deprecated)
    | ICMPType18AddressMaskReplyDeprecated -- ^ Address Mask Reply (Deprecated)
    | ICMPType19ReservedForSecurity -- ^ Reserved (for Security)
    | ICMPType20ReservedForRobustnessExperiment -- ^ Reserved (for Robustness Experiment)
    | ICMPType21ReservedForRobustnessExperiment -- ^ Reserved (for Robustness Experiment)
    | ICMPType22ReservedForRobustnessExperiment -- ^ Reserved (for Robustness Experiment)
    | ICMPType23ReservedForRobustnessExperiment -- ^ Reserved (for Robustness Experiment)
    | ICMPType24ReservedForRobustnessExperiment -- ^ Reserved (for Robustness Experiment)
    | ICMPType25ReservedForRobustnessExperiment -- ^ Reserved (for Robustness Experiment)
    | ICMPType26ReservedForRobustnessExperiment -- ^ Reserved (for Robustness Experiment)
    | ICMPType27ReservedForRobustnessExperiment -- ^ Reserved (for Robustness Experiment)
    | ICMPType28ReservedForRobustnessExperiment -- ^ Reserved (for Robustness Experiment)
    | ICMPType30TracerouteDeprecated -- ^ Traceroute (Deprecated)
    | ICMPType31DatagramConversionErrorDeprecated -- ^ Datagram Conversion Error (Deprecated)
    | ICMPType32MobileHostRedirectDeprecated -- ^ Mobile Host Redirect (Deprecated)
    | ICMPType33Ipv6WhereareyouDeprecated -- ^ IPv6 Where-Are-You (Deprecated)
    | ICMPType34Ipv6IamhereDeprecated -- ^ IPv6 I-Am-Here (Deprecated)
    | ICMPType35MobileRegistrationRequestDeprecated -- ^ Mobile Registration Request (Deprecated)
    | ICMPType36MobileRegistrationReplyDeprecated -- ^ Mobile Registration Reply (Deprecated)
    | ICMPType37DomainNameRequestDeprecated -- ^ Domain Name Request (Deprecated)
    | ICMPType38DomainNameReplyDeprecated -- ^ Domain Name Reply (Deprecated)
    | ICMPType39SkipDeprecated -- ^ SKIP (Deprecated)
    | ICMPType40Photuris -- ^ Photuris
    | ICMPType41IcmpMessagesUtilizedByExperimentalMobilityProtocolsSuchAsSeamoby -- ^ ICMP messages utilized by experimental         mobility protocols such as Seamoby
    | ICMPType42ExtendedEchoRequest -- ^ Extended Echo Request
    | ICMPType43ExtendedEchoReply -- ^ Extended Echo Reply
    | ICMPType253Rfc3692styleExperiment1 -- ^ RFC3692-style Experiment 1
    | ICMPType254Rfc3692styleExperiment2 -- ^ RFC3692-style Experiment 2
    | ICMPType255Reserved -- ^ Reserved
    deriving stock (Bounded, Eq, Enum, Generic, Ord, Show)


-- | Wrap a numeric ICMP code.
--
-- @since 1.0.0.0
newtype ICMPCodeNum = ICMPCodeNum Word8


-- | ICMP code.
--
-- @since 1.0.0.0
data ICMPCode
    = ICMPCodeUnknown -- ^ Unknown code
    | ICMPType0Code0 -- ^ Type 0 code 0 - No Code
    | ICMPType3Code0 -- ^ Type 3 code 0 - Net Unreachable
    | ICMPType3Code1 -- ^ Type 3 code 1 - Host Unreachable
    | ICMPType3Code2 -- ^ Type 3 code 2 - Protocol Unreachable
    | ICMPType3Code3 -- ^ Type 3 code 3 - Port Unreachable
    | ICMPType3Code4 -- ^ Type 3 code 4 - Fragmentation Needed and Don't         Fragment was Set
    | ICMPType3Code5 -- ^ Type 3 code 5 - Source Route Failed
    | ICMPType3Code6 -- ^ Type 3 code 6 - Destination Network Unknown
    | ICMPType3Code7 -- ^ Type 3 code 7 - Destination Host Unknown
    | ICMPType3Code8 -- ^ Type 3 code 8 - Source Host Isolated
    | ICMPType3Code9 -- ^ Type 3 code 9 - Communication with Destination         Network is Administratively Prohibited
    | ICMPType3Code10 -- ^ Type 3 code 10 - Communication with Destination Host is         Administratively Prohibited
    | ICMPType3Code11 -- ^ Type 3 code 11 - Destination Network Unreachable for Type         of Service
    | ICMPType3Code12 -- ^ Type 3 code 12 - Destination Host Unreachable for Type of         Service
    | ICMPType3Code13 -- ^ Type 3 code 13 - Communication Administratively Prohibited
    | ICMPType3Code14 -- ^ Type 3 code 14 - Host Precedence Violation
    | ICMPType3Code15 -- ^ Type 3 code 15 - Precedence cutoff in effect
    | ICMPType4Code0 -- ^ Type 4 code 0 - No Code
    | ICMPType5Code0 -- ^ Type 5 code 0 - Redirect Datagram for the Network (or subnet)
    | ICMPType5Code1 -- ^ Type 5 code 1 - Redirect Datagram for the Host
    | ICMPType5Code2 -- ^ Type 5 code 2 - Redirect Datagram for the Type of Service and Network
    | ICMPType5Code3 -- ^ Type 5 code 3 - Redirect Datagram for the Type of Service and Host
    | ICMPType6Code0 -- ^ Type 6 code 0 - Alternate Address for Host
    | ICMPType8Code0 -- ^ Type 8 code 0 - No Code
    | ICMPType9Code0 -- ^ Type 9 code 0 - Normal router advertisement
    | ICMPType9Code16 -- ^ Type 9 code 16 - Does not route common traffic
    | ICMPType10Code0 -- ^ Type 10 code 0 - No Code
    | ICMPType11Code0 -- ^ Type 11 code 0 - Time to Live exceeded in Transit
    | ICMPType11Code1 -- ^ Type 11 code 1 - Fragment Reassembly Time Exceeded
    | ICMPType12Code0 -- ^ Type 12 code 0 - Pointer indicates the error
    | ICMPType12Code1 -- ^ Type 12 code 1 - Missing a Required Option
    | ICMPType12Code2 -- ^ Type 12 code 2 - Bad Length
    | ICMPType13Code0 -- ^ Type 13 code 0 - No Code
    | ICMPType14Code0 -- ^ Type 14 code 0 - No Code
    | ICMPType15Code0 -- ^ Type 15 code 0 - No Code
    | ICMPType16Code0 -- ^ Type 16 code 0 - No Code
    | ICMPType17Code0 -- ^ Type 17 code 0 - No Code
    | ICMPType18Code0 -- ^ Type 18 code 0 - No Code
    | ICMPType40Code0 -- ^ Type 40 code 0 - Bad SPI
    | ICMPType40Code1 -- ^ Type 40 code 1 - Authentication Failed
    | ICMPType40Code2 -- ^ Type 40 code 2 - Decompression Failed
    | ICMPType40Code3 -- ^ Type 40 code 3 - Decryption Failed
    | ICMPType40Code4 -- ^ Type 40 code 4 - Need Authentication
    | ICMPType40Code5 -- ^ Type 40 code 5 - Need Authorization
    | ICMPType42Code0 -- ^ Type 42 code 0 - No Error
    | ICMPType43Code0 -- ^ Type 43 code 0 - No Error
    | ICMPType43Code1 -- ^ Type 43 code 1 - Malformed Query
    | ICMPType43Code2 -- ^ Type 43 code 2 - No Such Interface
    | ICMPType43Code3 -- ^ Type 43 code 3 - No Such Table Entry
    | ICMPType43Code4 -- ^ Type 43 code 4 - Multiple Interfaces Satisfy Query
    deriving stock (Bounded, Eq, Enum, Generic, Ord, Show)

-- | Get a list of 'ICMPCode' for a given 'ICMPType'.
--
-- @since 1.0.0.0
icmpCodesForType :: ICMPType -> [ICMPCode]
icmpCodesForType ty = case ty of
    ICMPTypeUnknown -> []
    ICMPType0EchoReply -> [
        ICMPType0Code0
        ]
    ICMPType3DestinationUnreachable -> [
        ICMPType3Code0,
        ICMPType3Code1,
        ICMPType3Code2,
        ICMPType3Code3,
        ICMPType3Code4,
        ICMPType3Code5,
        ICMPType3Code6,
        ICMPType3Code7,
        ICMPType3Code8,
        ICMPType3Code9,
        ICMPType3Code10,
        ICMPType3Code11,
        ICMPType3Code12,
        ICMPType3Code13,
        ICMPType3Code14,
        ICMPType3Code15
        ]
    ICMPType4SourceQuenchDeprecated -> [
        ICMPType4Code0
        ]
    ICMPType5Redirect -> [
        ICMPType5Code0,
        ICMPType5Code1,
        ICMPType5Code2,
        ICMPType5Code3
        ]
    ICMPType6AlternateHostAddressDeprecated -> [
        ICMPType6Code0
        ]
    ICMPType8Echo -> [
        ICMPType8Code0
        ]
    ICMPType9RouterAdvertisement -> [
        ICMPType9Code0,
        ICMPType9Code16
        ]
    ICMPType10RouterSolicitation -> [
        ICMPType10Code0
        ]
    ICMPType11TimeExceeded -> [
        ICMPType11Code0,
        ICMPType11Code1
        ]
    ICMPType12ParameterProblem -> [
        ICMPType12Code0,
        ICMPType12Code1,
        ICMPType12Code2
        ]
    ICMPType13Timestamp -> [
        ICMPType13Code0
        ]
    ICMPType14TimestampReply -> [
        ICMPType14Code0
        ]
    ICMPType15InformationRequestDeprecated -> [
        ICMPType15Code0
        ]
    ICMPType16InformationReplyDeprecated -> [
        ICMPType16Code0
        ]
    ICMPType17AddressMaskRequestDeprecated -> [
        ICMPType17Code0
        ]
    ICMPType18AddressMaskReplyDeprecated -> [
        ICMPType18Code0
        ]
    ICMPType19ReservedForSecurity -> [
        ]
    ICMPType20ReservedForRobustnessExperiment -> [
        ]
    ICMPType21ReservedForRobustnessExperiment -> [
        ]
    ICMPType22ReservedForRobustnessExperiment -> [
        ]
    ICMPType23ReservedForRobustnessExperiment -> [
        ]
    ICMPType24ReservedForRobustnessExperiment -> [
        ]
    ICMPType25ReservedForRobustnessExperiment -> [
        ]
    ICMPType26ReservedForRobustnessExperiment -> [
        ]
    ICMPType27ReservedForRobustnessExperiment -> [
        ]
    ICMPType28ReservedForRobustnessExperiment -> [
        ]
    ICMPType30TracerouteDeprecated -> [
        ]
    ICMPType31DatagramConversionErrorDeprecated -> [
        ]
    ICMPType32MobileHostRedirectDeprecated -> [
        ]
    ICMPType33Ipv6WhereareyouDeprecated -> [
        ]
    ICMPType34Ipv6IamhereDeprecated -> [
        ]
    ICMPType35MobileRegistrationRequestDeprecated -> [
        ]
    ICMPType36MobileRegistrationReplyDeprecated -> [
        ]
    ICMPType37DomainNameRequestDeprecated -> [
        ]
    ICMPType38DomainNameReplyDeprecated -> [
        ]
    ICMPType39SkipDeprecated -> [
        ]
    ICMPType40Photuris -> [
        ICMPType40Code0,
        ICMPType40Code1,
        ICMPType40Code2,
        ICMPType40Code3,
        ICMPType40Code4,
        ICMPType40Code5
        ]
    ICMPType41IcmpMessagesUtilizedByExperimentalMobilityProtocolsSuchAsSeamoby -> [
        ]
    ICMPType42ExtendedEchoRequest -> [
        ICMPType42Code0
        ]
    ICMPType43ExtendedEchoReply -> [
        ICMPType43Code0,
        ICMPType43Code1,
        ICMPType43Code2,
        ICMPType43Code3,
        ICMPType43Code4
        ]
    ICMPType253Rfc3692styleExperiment1 -> [
        ]
    ICMPType254Rfc3692styleExperiment2 -> [
        ]
    ICMPType255Reserved -> [
        ]


-- | Convert a 'ICMPType' into a string.
--
-- @since 1.0.0.0
icmpTypeToStringNum :: IsString a => ICMPType -> a
icmpTypeToStringNum t = case t of
    ICMPType0EchoReply -> "0"
    ICMPType3DestinationUnreachable -> "3"
    ICMPType4SourceQuenchDeprecated -> "4"
    ICMPType5Redirect -> "5"
    ICMPType6AlternateHostAddressDeprecated -> "6"
    ICMPType8Echo -> "8"
    ICMPType9RouterAdvertisement -> "9"
    ICMPType10RouterSolicitation -> "10"
    ICMPType11TimeExceeded -> "11"
    ICMPType12ParameterProblem -> "12"
    ICMPType13Timestamp -> "13"
    ICMPType14TimestampReply -> "14"
    ICMPType15InformationRequestDeprecated -> "15"
    ICMPType16InformationReplyDeprecated -> "16"
    ICMPType17AddressMaskRequestDeprecated -> "17"
    ICMPType18AddressMaskReplyDeprecated -> "18"
    ICMPType19ReservedForSecurity -> "19"
    ICMPType20ReservedForRobustnessExperiment -> "20"
    ICMPType21ReservedForRobustnessExperiment -> "21"
    ICMPType22ReservedForRobustnessExperiment -> "22"
    ICMPType23ReservedForRobustnessExperiment -> "23"
    ICMPType24ReservedForRobustnessExperiment -> "24"
    ICMPType25ReservedForRobustnessExperiment -> "25"
    ICMPType26ReservedForRobustnessExperiment -> "26"
    ICMPType27ReservedForRobustnessExperiment -> "27"
    ICMPType28ReservedForRobustnessExperiment -> "28"
    ICMPType30TracerouteDeprecated -> "30"
    ICMPType31DatagramConversionErrorDeprecated -> "31"
    ICMPType32MobileHostRedirectDeprecated -> "32"
    ICMPType33Ipv6WhereareyouDeprecated -> "33"
    ICMPType34Ipv6IamhereDeprecated -> "34"
    ICMPType35MobileRegistrationRequestDeprecated -> "35"
    ICMPType36MobileRegistrationReplyDeprecated -> "36"
    ICMPType37DomainNameRequestDeprecated -> "37"
    ICMPType38DomainNameReplyDeprecated -> "38"
    ICMPType39SkipDeprecated -> "39"
    ICMPType40Photuris -> "40"
    ICMPType41IcmpMessagesUtilizedByExperimentalMobilityProtocolsSuchAsSeamoby -> "41"
    ICMPType42ExtendedEchoRequest -> "42"
    ICMPType43ExtendedEchoReply -> "43"
    ICMPType253Rfc3692styleExperiment1 -> "253"
    ICMPType254Rfc3692styleExperiment2 -> "254"
    ICMPType255Reserved -> "255"
    ICMPTypeUnknown -> "?"


-- | Convert a string into a 'ICMPType'.
--
-- @since 1.0.0.0
icmpTypeFromStringNum :: (Eq a, IsString a) => a -> ICMPType
icmpTypeFromStringNum s = case s of
    "0" -> ICMPType0EchoReply
    "3" -> ICMPType3DestinationUnreachable
    "4" -> ICMPType4SourceQuenchDeprecated
    "5" -> ICMPType5Redirect
    "6" -> ICMPType6AlternateHostAddressDeprecated
    "8" -> ICMPType8Echo
    "9" -> ICMPType9RouterAdvertisement
    "10" -> ICMPType10RouterSolicitation
    "11" -> ICMPType11TimeExceeded
    "12" -> ICMPType12ParameterProblem
    "13" -> ICMPType13Timestamp
    "14" -> ICMPType14TimestampReply
    "15" -> ICMPType15InformationRequestDeprecated
    "16" -> ICMPType16InformationReplyDeprecated
    "17" -> ICMPType17AddressMaskRequestDeprecated
    "18" -> ICMPType18AddressMaskReplyDeprecated
    "19" -> ICMPType19ReservedForSecurity
    "20" -> ICMPType20ReservedForRobustnessExperiment
    "21" -> ICMPType21ReservedForRobustnessExperiment
    "22" -> ICMPType22ReservedForRobustnessExperiment
    "23" -> ICMPType23ReservedForRobustnessExperiment
    "24" -> ICMPType24ReservedForRobustnessExperiment
    "25" -> ICMPType25ReservedForRobustnessExperiment
    "26" -> ICMPType26ReservedForRobustnessExperiment
    "27" -> ICMPType27ReservedForRobustnessExperiment
    "28" -> ICMPType28ReservedForRobustnessExperiment
    "30" -> ICMPType30TracerouteDeprecated
    "31" -> ICMPType31DatagramConversionErrorDeprecated
    "32" -> ICMPType32MobileHostRedirectDeprecated
    "33" -> ICMPType33Ipv6WhereareyouDeprecated
    "34" -> ICMPType34Ipv6IamhereDeprecated
    "35" -> ICMPType35MobileRegistrationRequestDeprecated
    "36" -> ICMPType36MobileRegistrationReplyDeprecated
    "37" -> ICMPType37DomainNameRequestDeprecated
    "38" -> ICMPType38DomainNameReplyDeprecated
    "39" -> ICMPType39SkipDeprecated
    "40" -> ICMPType40Photuris
    "41" -> ICMPType41IcmpMessagesUtilizedByExperimentalMobilityProtocolsSuchAsSeamoby
    "42" -> ICMPType42ExtendedEchoRequest
    "43" -> ICMPType43ExtendedEchoReply
    "253" -> ICMPType253Rfc3692styleExperiment1
    "254" -> ICMPType254Rfc3692styleExperiment2
    "255" -> ICMPType255Reserved
    _ -> ICMPTypeUnknown


-- | Turn an 'ICMPType' into a 'ICMPTypeNum'.
--
-- @since 1.0.0.0
icmpTypeToNum :: ICMPType -> ICMPTypeNum
icmpTypeToNum t = case t of
    ICMPType0EchoReply -> ICMPTypeNum 0
    ICMPType3DestinationUnreachable -> ICMPTypeNum 3
    ICMPType4SourceQuenchDeprecated -> ICMPTypeNum 4
    ICMPType5Redirect -> ICMPTypeNum 5
    ICMPType6AlternateHostAddressDeprecated -> ICMPTypeNum 6
    ICMPType8Echo -> ICMPTypeNum 8
    ICMPType9RouterAdvertisement -> ICMPTypeNum 9
    ICMPType10RouterSolicitation -> ICMPTypeNum 10
    ICMPType11TimeExceeded -> ICMPTypeNum 11
    ICMPType12ParameterProblem -> ICMPTypeNum 12
    ICMPType13Timestamp -> ICMPTypeNum 13
    ICMPType14TimestampReply -> ICMPTypeNum 14
    ICMPType15InformationRequestDeprecated -> ICMPTypeNum 15
    ICMPType16InformationReplyDeprecated -> ICMPTypeNum 16
    ICMPType17AddressMaskRequestDeprecated -> ICMPTypeNum 17
    ICMPType18AddressMaskReplyDeprecated -> ICMPTypeNum 18
    ICMPType19ReservedForSecurity -> ICMPTypeNum 19
    ICMPType20ReservedForRobustnessExperiment -> ICMPTypeNum 20
    ICMPType21ReservedForRobustnessExperiment -> ICMPTypeNum 21
    ICMPType22ReservedForRobustnessExperiment -> ICMPTypeNum 22
    ICMPType23ReservedForRobustnessExperiment -> ICMPTypeNum 23
    ICMPType24ReservedForRobustnessExperiment -> ICMPTypeNum 24
    ICMPType25ReservedForRobustnessExperiment -> ICMPTypeNum 25
    ICMPType26ReservedForRobustnessExperiment -> ICMPTypeNum 26
    ICMPType27ReservedForRobustnessExperiment -> ICMPTypeNum 27
    ICMPType28ReservedForRobustnessExperiment -> ICMPTypeNum 28
    ICMPType30TracerouteDeprecated -> ICMPTypeNum 30
    ICMPType31DatagramConversionErrorDeprecated -> ICMPTypeNum 31
    ICMPType32MobileHostRedirectDeprecated -> ICMPTypeNum 32
    ICMPType33Ipv6WhereareyouDeprecated -> ICMPTypeNum 33
    ICMPType34Ipv6IamhereDeprecated -> ICMPTypeNum 34
    ICMPType35MobileRegistrationRequestDeprecated -> ICMPTypeNum 35
    ICMPType36MobileRegistrationReplyDeprecated -> ICMPTypeNum 36
    ICMPType37DomainNameRequestDeprecated -> ICMPTypeNum 37
    ICMPType38DomainNameReplyDeprecated -> ICMPTypeNum 38
    ICMPType39SkipDeprecated -> ICMPTypeNum 39
    ICMPType40Photuris -> ICMPTypeNum 40
    ICMPType41IcmpMessagesUtilizedByExperimentalMobilityProtocolsSuchAsSeamoby -> ICMPTypeNum 41
    ICMPType42ExtendedEchoRequest -> ICMPTypeNum 42
    ICMPType43ExtendedEchoReply -> ICMPTypeNum 43
    ICMPType253Rfc3692styleExperiment1 -> ICMPTypeNum 253
    ICMPType254Rfc3692styleExperiment2 -> ICMPTypeNum 254
    ICMPType255Reserved -> ICMPTypeNum 255
    ICMPTypeUnknown -> ICMPTypeNum 0


-- | Test if an 'ICMPType' has been deprecated.
--
-- @since 1.0.0.0
isICMPTypeDeprecated :: ICMPType -> Bool
isICMPTypeDeprecated ty = case ty of
   ICMPType0EchoReply-> False
   ICMPType3DestinationUnreachable-> False
   ICMPType4SourceQuenchDeprecated-> True
   ICMPType5Redirect-> False
   ICMPType6AlternateHostAddressDeprecated-> True
   ICMPType8Echo-> False
   ICMPType9RouterAdvertisement-> False
   ICMPType10RouterSolicitation-> False
   ICMPType11TimeExceeded-> False
   ICMPType12ParameterProblem-> False
   ICMPType13Timestamp-> False
   ICMPType14TimestampReply-> False
   ICMPType15InformationRequestDeprecated-> True
   ICMPType16InformationReplyDeprecated-> True
   ICMPType17AddressMaskRequestDeprecated-> True
   ICMPType18AddressMaskReplyDeprecated-> True
   ICMPType19ReservedForSecurity-> False
   ICMPType20ReservedForRobustnessExperiment-> False
   ICMPType21ReservedForRobustnessExperiment-> False
   ICMPType22ReservedForRobustnessExperiment-> False
   ICMPType23ReservedForRobustnessExperiment-> False
   ICMPType24ReservedForRobustnessExperiment-> False
   ICMPType25ReservedForRobustnessExperiment-> False
   ICMPType26ReservedForRobustnessExperiment-> False
   ICMPType27ReservedForRobustnessExperiment-> False
   ICMPType28ReservedForRobustnessExperiment-> False
   ICMPType30TracerouteDeprecated-> True
   ICMPType31DatagramConversionErrorDeprecated-> True
   ICMPType32MobileHostRedirectDeprecated-> True
   ICMPType33Ipv6WhereareyouDeprecated-> True
   ICMPType34Ipv6IamhereDeprecated-> True
   ICMPType35MobileRegistrationRequestDeprecated-> True
   ICMPType36MobileRegistrationReplyDeprecated-> True
   ICMPType37DomainNameRequestDeprecated-> True
   ICMPType38DomainNameReplyDeprecated-> True
   ICMPType39SkipDeprecated-> True
   ICMPType40Photuris-> False
   ICMPType41IcmpMessagesUtilizedByExperimentalMobilityProtocolsSuchAsSeamoby-> False
   ICMPType42ExtendedEchoRequest-> False
   ICMPType43ExtendedEchoReply-> False
   ICMPType253Rfc3692styleExperiment1-> False
   ICMPType254Rfc3692styleExperiment2-> False
   ICMPType255Reserved-> False
   ICMPTypeUnknown -> False
