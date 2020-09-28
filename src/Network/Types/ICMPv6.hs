{-|
Module      : Network.Types.ICMPv6
Description : Data types for ICMPv6 types and codes
Copyright   : (c) 2020 Adam Flott
License     : BSD-3-Clause
Maintainer  : adam@adamflott.com
Stability   : experimental
Portability : POSIX

Data types and conversions for ICMPv6 automatically built from the specification at
<https://www.iana.org/assignments/icmpv6-parameters/icmpv6-parameters.xml>

Specification date: ?
-}
module Network.Types.ICMPv6 (
    -- * Types
    ICMPv6Type(..)

    -- * Codes
    , ICMPv6CodeNum(..)
    , ICMPv6Code(..)

    -- * Codes from Type
    , icmpv6CodesForType

    -- * Conversions
    , icmpv6TypeToStringNum
    , icmpv6TypeFromStringNum
    , icmpv6TypeToNum

    -- * Deprecated testing
    , isICMPv6TypeDeprecated

) where


-- base
import Data.String (IsString)
import Data.Word (Word8)


-- | Wrap a numeric ICMPv6 type.
--
-- @since 1.0.0.0
newtype ICMPv6TypeNum = ICMPv6TypeNum Word8


-- | ICMPv6 type.
--
-- @since 1.0.0.0
data ICMPv6Type
    = ICMPv6TypeUnknown
    | ICMPv6Type0Reserved -- ^ Reserved
    | ICMPv6Type1DestinationUnreachable -- ^ Destination Unreachable
    | ICMPv6Type2PacketTooBig -- ^ Packet Too Big
    | ICMPv6Type3TimeExceeded -- ^ Time Exceeded
    | ICMPv6Type4ParameterProblem -- ^ Parameter Problem
    | ICMPv6Type100PrivateExperimentation -- ^ Private experimentation
    | ICMPv6Type101PrivateExperimentation -- ^ Private experimentation
    | ICMPv6Type127ReservedForExpansionOfIcmpv6ErrorMessages -- ^ Reserved for expansion of ICMPv6 error messages
    | ICMPv6Type128EchoRequest -- ^ Echo Request
    | ICMPv6Type129EchoReply -- ^ Echo Reply
    | ICMPv6Type130MulticastListenerQuery -- ^ Multicast Listener Query
    | ICMPv6Type131MulticastListenerReport -- ^ Multicast Listener Report
    | ICMPv6Type132MulticastListenerDone -- ^ Multicast Listener Done
    | ICMPv6Type133RouterSolicitation -- ^ Router Solicitation
    | ICMPv6Type134RouterAdvertisement -- ^ Router Advertisement
    | ICMPv6Type135NeighborSolicitation -- ^ Neighbor Solicitation
    | ICMPv6Type136NeighborAdvertisement -- ^ Neighbor Advertisement
    | ICMPv6Type137RedirectMessage -- ^ Redirect Message
    | ICMPv6Type138RouterRenumbering -- ^ Router Renumbering
    | ICMPv6Type139IcmpNodeInformationQuery -- ^ ICMP Node Information Query
    | ICMPv6Type140IcmpNodeInformationResponse -- ^ ICMP Node Information Response
    | ICMPv6Type141InverseNeighborDiscoverySolicitationMessage -- ^ Inverse Neighbor Discovery Solicitation Message
    | ICMPv6Type142InverseNeighborDiscoveryAdvertisementMessage -- ^ Inverse Neighbor Discovery Advertisement Message
    | ICMPv6Type143Version2MulticastListenerReport -- ^ Version 2 Multicast Listener Report
    | ICMPv6Type144HomeAgentAddressDiscoveryRequestMessage -- ^ Home Agent Address Discovery Request Message
    | ICMPv6Type145HomeAgentAddressDiscoveryReplyMessage -- ^ Home Agent Address Discovery Reply Message
    | ICMPv6Type146MobilePrefixSolicitation -- ^ Mobile Prefix Solicitation
    | ICMPv6Type147MobilePrefixAdvertisement -- ^ Mobile Prefix Advertisement
    | ICMPv6Type148CertificationPathSolicitationMessage -- ^ Certification Path Solicitation Message
    | ICMPv6Type149CertificationPathAdvertisementMessage -- ^ Certification Path Advertisement Message
    | ICMPv6Type150IcmpMessagesUtilizedByExperimentalMobilityProtocolsSuchAsSeamoby -- ^ ICMP messages utilized by experimental            mobility protocols such as Seamoby
    | ICMPv6Type151MulticastRouterAdvertisement -- ^ Multicast Router Advertisement
    | ICMPv6Type152MulticastRouterSolicitation -- ^ Multicast Router Solicitation
    | ICMPv6Type153MulticastRouterTermination -- ^ Multicast Router Termination
    | ICMPv6Type154Fmipv6Messages -- ^ FMIPv6 Messages
    | ICMPv6Type155RplControlMessage -- ^ RPL Control Message
    | ICMPv6Type156Ilnpv6LocatorUpdateMessage -- ^ ILNPv6 Locator Update Message
    | ICMPv6Type157DuplicateAddressRequest -- ^ Duplicate Address Request
    | ICMPv6Type158DuplicateAddressConfirmation -- ^ Duplicate Address Confirmation
    | ICMPv6Type159MplControlMessage -- ^ MPL Control Message
    | ICMPv6Type160ExtendedEchoRequest -- ^ Extended Echo Request
    | ICMPv6Type161ExtendedEchoReply -- ^ Extended Echo Reply
    | ICMPv6Type200PrivateExperimentation -- ^ Private experimentation
    | ICMPv6Type201PrivateExperimentation -- ^ Private experimentation
    | ICMPv6Type255ReservedForExpansionOfIcmpv6InformationalMessages -- ^ Reserved for expansion of ICMPv6 informational    messages
    deriving stock (Bounded, Eq, Enum, Ord, Show)


-- | Wrap a numeric ICMPv6 code.
--
-- @since 1.0.0.0
newtype ICMPv6CodeNum = ICMPv6CodeNum Word8


-- | ICMPv6 code.
--
-- @since 1.0.0.0
data ICMPv6Code
    = ICMPv6CodeUnknown -- ^ Unknown code
    | ICMPv6Type1Code0 -- ^ Type 1 code 0 - no route to destination
    | ICMPv6Type1Code1 -- ^ Type 1 code 1 - communication with destination administratively prohibited
    | ICMPv6Type1Code2 -- ^ Type 1 code 2 - beyond scope of source address
    | ICMPv6Type1Code3 -- ^ Type 1 code 3 - address unreachable
    | ICMPv6Type1Code4 -- ^ Type 1 code 4 - port unreachable
    | ICMPv6Type1Code5 -- ^ Type 1 code 5 - source address failed ingress/egress policy
    | ICMPv6Type1Code6 -- ^ Type 1 code 6 - reject route to destination
    | ICMPv6Type1Code7 -- ^ Type 1 code 7 - Error in Source Routing Header
    | ICMPv6Type1Code8 -- ^ Type 1 code 8 - Headers too long
    | ICMPv6Type2Code0 -- ^ Type 2 code 0 - N/A - No description in spec
    | ICMPv6Type3Code0 -- ^ Type 3 code 0 - hop limit exceeded in transit
    | ICMPv6Type3Code1 -- ^ Type 3 code 1 - fragment reassembly time exceeded
    | ICMPv6Type4Code0 -- ^ Type 4 code 0 - erroneous header field encountered
    | ICMPv6Type4Code1 -- ^ Type 4 code 1 - unrecognized Next Header type encountered
    | ICMPv6Type4Code2 -- ^ Type 4 code 2 - unrecognized IPv6 option encountered
    | ICMPv6Type4Code3 -- ^ Type 4 code 3 - IPv6 First Fragment has incomplete IPv6 Header Chain
    | ICMPv6Type4Code4 -- ^ Type 4 code 4 - SR Upper-layer Header Error
    | ICMPv6Type4Code5 -- ^ Type 4 code 5 - Unrecognized Next Header type encountered by intermediate node
    | ICMPv6Type4Code6 -- ^ Type 4 code 6 - Extension header too big
    | ICMPv6Type4Code7 -- ^ Type 4 code 7 - Extension header chain too long
    | ICMPv6Type4Code8 -- ^ Type 4 code 8 - Too many extension headers
    | ICMPv6Type4Code9 -- ^ Type 4 code 9 - Too many options in extension header
    | ICMPv6Type4Code10 -- ^ Type 4 code 10 - Option too big
    | ICMPv6Type128Code0 -- ^ Type 128 code 0 - N/A - No description in spec
    | ICMPv6Type129Code0 -- ^ Type 129 code 0 - N/A - No description in spec
    | ICMPv6Type130Code0 -- ^ Type 130 code 0 - N/A - No description in spec
    | ICMPv6Type131Code0 -- ^ Type 131 code 0 - N/A - No description in spec
    | ICMPv6Type132Code0 -- ^ Type 132 code 0 - N/A - No description in spec
    | ICMPv6Type133Code0 -- ^ Type 133 code 0 - N/A - No description in spec
    | ICMPv6Type134Code0 -- ^ Type 134 code 0 - N/A - No description in spec
    | ICMPv6Type135Code0 -- ^ Type 135 code 0 - N/A - No description in spec
    | ICMPv6Type136Code0 -- ^ Type 136 code 0 - N/A - No description in spec
    | ICMPv6Type137Code0 -- ^ Type 137 code 0 - N/A - No description in spec
    | ICMPv6Type138Code0 -- ^ Type 138 code 0 - Router Renumbering Command
    | ICMPv6Type138Code1 -- ^ Type 138 code 1 - Router Renumbering Result
    | ICMPv6Type138Code255 -- ^ Type 138 code 255 - Sequence Number Reset
    | ICMPv6Type139Code0 -- ^ Type 139 code 0 - The Data field contains an IPv6 address which is the Subject of this Query.
    | ICMPv6Type139Code1 -- ^ Type 139 code 1 - The Data field contains a name which is the Subject of this Query, or is empty, as in the case of a NOOP.
    | ICMPv6Type139Code2 -- ^ Type 139 code 2 - The Data field contains an IPv4 address which is the Subject of this Query.
    | ICMPv6Type140Code0 -- ^ Type 140 code 0 - A successful reply.  The Reply Data field may or may not be empty.
    | ICMPv6Type140Code1 -- ^ Type 140 code 1 - The Responder refuses to supply the answer.  The Reply Data field will be empty.
    | ICMPv6Type140Code2 -- ^ Type 140 code 2 - The Qtype of the Query is unknown to the Responder.  The Reply Data field will be empty.
    | ICMPv6Type141Code0 -- ^ Type 141 code 0 - N/A - No description in spec
    | ICMPv6Type142Code0 -- ^ Type 142 code 0 - N/A - No description in spec
    | ICMPv6Type144Code0 -- ^ Type 144 code 0 - N/A - No description in spec
    | ICMPv6Type145Code0 -- ^ Type 145 code 0 - N/A - No description in spec
    | ICMPv6Type146Code0 -- ^ Type 146 code 0 - N/A - No description in spec
    | ICMPv6Type147Code0 -- ^ Type 147 code 0 - N/A - No description in spec
    | ICMPv6Type157Code0 -- ^ Type 157 code 0 - DAR message
    | ICMPv6Type157Code1 -- ^ Type 157 code 1 - EDAR message with 64-bit ROVR field
    | ICMPv6Type157Code2 -- ^ Type 157 code 2 - EDAR message with 128-bit ROVR field
    | ICMPv6Type157Code3 -- ^ Type 157 code 3 - EDAR message with 192-bit ROVR field
    | ICMPv6Type157Code4 -- ^ Type 157 code 4 - EDAR message with 256-bit ROVR field
    | ICMPv6Type158Code0 -- ^ Type 158 code 0 - DAC message
    | ICMPv6Type158Code1 -- ^ Type 158 code 1 - EDAC message with 64-bit ROVR field
    | ICMPv6Type158Code2 -- ^ Type 158 code 2 - EDAC message with 128-bit ROVR field
    | ICMPv6Type158Code3 -- ^ Type 158 code 3 - EDAC message with 192-bit ROVR field
    | ICMPv6Type158Code4 -- ^ Type 158 code 4 - EDAC message with 256-bit ROVR field
    | ICMPv6Type160Code0 -- ^ Type 160 code 0 - No Error
    | ICMPv6Type161Code0 -- ^ Type 161 code 0 - No Error
    | ICMPv6Type161Code1 -- ^ Type 161 code 1 - Malformed Query
    | ICMPv6Type161Code2 -- ^ Type 161 code 2 - No Such Interface
    | ICMPv6Type161Code3 -- ^ Type 161 code 3 - No Such Table Entry
    | ICMPv6Type161Code4 -- ^ Type 161 code 4 - Multiple Interfaces Satisfy Query


-- | Get a list of 'ICMPv6Code' for a given 'ICMPv6Type'.
--
-- @since 1.0.0.0
icmpv6CodesForType :: ICMPv6Type -> [ICMPv6Code]
icmpv6CodesForType ty = case ty of
    ICMPv6TypeUnknown -> []
    ICMPv6Type0Reserved -> [
        ]
    ICMPv6Type1DestinationUnreachable -> [
        ICMPv6Type1Code0,
        ICMPv6Type1Code1,
        ICMPv6Type1Code2,
        ICMPv6Type1Code3,
        ICMPv6Type1Code4,
        ICMPv6Type1Code5,
        ICMPv6Type1Code6,
        ICMPv6Type1Code7,
        ICMPv6Type1Code8
        ]
    ICMPv6Type2PacketTooBig -> [
        ICMPv6Type2Code0
        ]
    ICMPv6Type3TimeExceeded -> [
        ICMPv6Type3Code0,
        ICMPv6Type3Code1
        ]
    ICMPv6Type4ParameterProblem -> [
        ICMPv6Type4Code0,
        ICMPv6Type4Code1,
        ICMPv6Type4Code2,
        ICMPv6Type4Code3,
        ICMPv6Type4Code4,
        ICMPv6Type4Code5,
        ICMPv6Type4Code6,
        ICMPv6Type4Code7,
        ICMPv6Type4Code8,
        ICMPv6Type4Code9,
        ICMPv6Type4Code10
        ]
    ICMPv6Type100PrivateExperimentation -> [
        ]
    ICMPv6Type101PrivateExperimentation -> [
        ]
    ICMPv6Type127ReservedForExpansionOfIcmpv6ErrorMessages -> [
        ]
    ICMPv6Type128EchoRequest -> [
        ICMPv6Type128Code0
        ]
    ICMPv6Type129EchoReply -> [
        ICMPv6Type129Code0
        ]
    ICMPv6Type130MulticastListenerQuery -> [
        ICMPv6Type130Code0
        ]
    ICMPv6Type131MulticastListenerReport -> [
        ICMPv6Type131Code0
        ]
    ICMPv6Type132MulticastListenerDone -> [
        ICMPv6Type132Code0
        ]
    ICMPv6Type133RouterSolicitation -> [
        ICMPv6Type133Code0
        ]
    ICMPv6Type134RouterAdvertisement -> [
        ICMPv6Type134Code0
        ]
    ICMPv6Type135NeighborSolicitation -> [
        ICMPv6Type135Code0
        ]
    ICMPv6Type136NeighborAdvertisement -> [
        ICMPv6Type136Code0
        ]
    ICMPv6Type137RedirectMessage -> [
        ICMPv6Type137Code0
        ]
    ICMPv6Type138RouterRenumbering -> [
        ICMPv6Type138Code0,
        ICMPv6Type138Code1,
        ICMPv6Type138Code255
        ]
    ICMPv6Type139IcmpNodeInformationQuery -> [
        ICMPv6Type139Code0,
        ICMPv6Type139Code1,
        ICMPv6Type139Code2
        ]
    ICMPv6Type140IcmpNodeInformationResponse -> [
        ICMPv6Type140Code0,
        ICMPv6Type140Code1,
        ICMPv6Type140Code2
        ]
    ICMPv6Type141InverseNeighborDiscoverySolicitationMessage -> [
        ICMPv6Type141Code0
        ]
    ICMPv6Type142InverseNeighborDiscoveryAdvertisementMessage -> [
        ICMPv6Type142Code0
        ]
    ICMPv6Type143Version2MulticastListenerReport -> [
        ]
    ICMPv6Type144HomeAgentAddressDiscoveryRequestMessage -> [
        ICMPv6Type144Code0
        ]
    ICMPv6Type145HomeAgentAddressDiscoveryReplyMessage -> [
        ICMPv6Type145Code0
        ]
    ICMPv6Type146MobilePrefixSolicitation -> [
        ICMPv6Type146Code0
        ]
    ICMPv6Type147MobilePrefixAdvertisement -> [
        ICMPv6Type147Code0
        ]
    ICMPv6Type148CertificationPathSolicitationMessage -> [
        ]
    ICMPv6Type149CertificationPathAdvertisementMessage -> [
        ]
    ICMPv6Type150IcmpMessagesUtilizedByExperimentalMobilityProtocolsSuchAsSeamoby -> [
        ]
    ICMPv6Type151MulticastRouterAdvertisement -> [
        ]
    ICMPv6Type152MulticastRouterSolicitation -> [
        ]
    ICMPv6Type153MulticastRouterTermination -> [
        ]
    ICMPv6Type154Fmipv6Messages -> [
        ]
    ICMPv6Type155RplControlMessage -> [
        ]
    ICMPv6Type156Ilnpv6LocatorUpdateMessage -> [
        ]
    ICMPv6Type157DuplicateAddressRequest -> [
        ICMPv6Type157Code0,
        ICMPv6Type157Code1,
        ICMPv6Type157Code2,
        ICMPv6Type157Code3,
        ICMPv6Type157Code4
        ]
    ICMPv6Type158DuplicateAddressConfirmation -> [
        ICMPv6Type158Code0,
        ICMPv6Type158Code1,
        ICMPv6Type158Code2,
        ICMPv6Type158Code3,
        ICMPv6Type158Code4
        ]
    ICMPv6Type159MplControlMessage -> [
        ]
    ICMPv6Type160ExtendedEchoRequest -> [
        ICMPv6Type160Code0
        ]
    ICMPv6Type161ExtendedEchoReply -> [
        ICMPv6Type161Code0,
        ICMPv6Type161Code1,
        ICMPv6Type161Code2,
        ICMPv6Type161Code3,
        ICMPv6Type161Code4
        ]
    ICMPv6Type200PrivateExperimentation -> [
        ]
    ICMPv6Type201PrivateExperimentation -> [
        ]
    ICMPv6Type255ReservedForExpansionOfIcmpv6InformationalMessages -> [
        ]


-- | Convert a 'ICMPv6Type' into a string.
--
-- @since 1.0.0.0
icmpv6TypeToStringNum :: IsString a => ICMPv6Type -> a
icmpv6TypeToStringNum t = case t of
    ICMPv6Type0Reserved -> "0"
    ICMPv6Type1DestinationUnreachable -> "1"
    ICMPv6Type2PacketTooBig -> "2"
    ICMPv6Type3TimeExceeded -> "3"
    ICMPv6Type4ParameterProblem -> "4"
    ICMPv6Type100PrivateExperimentation -> "100"
    ICMPv6Type101PrivateExperimentation -> "101"
    ICMPv6Type127ReservedForExpansionOfIcmpv6ErrorMessages -> "127"
    ICMPv6Type128EchoRequest -> "128"
    ICMPv6Type129EchoReply -> "129"
    ICMPv6Type130MulticastListenerQuery -> "130"
    ICMPv6Type131MulticastListenerReport -> "131"
    ICMPv6Type132MulticastListenerDone -> "132"
    ICMPv6Type133RouterSolicitation -> "133"
    ICMPv6Type134RouterAdvertisement -> "134"
    ICMPv6Type135NeighborSolicitation -> "135"
    ICMPv6Type136NeighborAdvertisement -> "136"
    ICMPv6Type137RedirectMessage -> "137"
    ICMPv6Type138RouterRenumbering -> "138"
    ICMPv6Type139IcmpNodeInformationQuery -> "139"
    ICMPv6Type140IcmpNodeInformationResponse -> "140"
    ICMPv6Type141InverseNeighborDiscoverySolicitationMessage -> "141"
    ICMPv6Type142InverseNeighborDiscoveryAdvertisementMessage -> "142"
    ICMPv6Type143Version2MulticastListenerReport -> "143"
    ICMPv6Type144HomeAgentAddressDiscoveryRequestMessage -> "144"
    ICMPv6Type145HomeAgentAddressDiscoveryReplyMessage -> "145"
    ICMPv6Type146MobilePrefixSolicitation -> "146"
    ICMPv6Type147MobilePrefixAdvertisement -> "147"
    ICMPv6Type148CertificationPathSolicitationMessage -> "148"
    ICMPv6Type149CertificationPathAdvertisementMessage -> "149"
    ICMPv6Type150IcmpMessagesUtilizedByExperimentalMobilityProtocolsSuchAsSeamoby -> "150"
    ICMPv6Type151MulticastRouterAdvertisement -> "151"
    ICMPv6Type152MulticastRouterSolicitation -> "152"
    ICMPv6Type153MulticastRouterTermination -> "153"
    ICMPv6Type154Fmipv6Messages -> "154"
    ICMPv6Type155RplControlMessage -> "155"
    ICMPv6Type156Ilnpv6LocatorUpdateMessage -> "156"
    ICMPv6Type157DuplicateAddressRequest -> "157"
    ICMPv6Type158DuplicateAddressConfirmation -> "158"
    ICMPv6Type159MplControlMessage -> "159"
    ICMPv6Type160ExtendedEchoRequest -> "160"
    ICMPv6Type161ExtendedEchoReply -> "161"
    ICMPv6Type200PrivateExperimentation -> "200"
    ICMPv6Type201PrivateExperimentation -> "201"
    ICMPv6Type255ReservedForExpansionOfIcmpv6InformationalMessages -> "255"
    ICMPv6TypeUnknown -> "?"


-- | Convert a string into a 'ICMPv6Type'.
--
-- @since 1.0.0.0
icmpv6TypeFromStringNum :: (Eq a, IsString a) => a -> ICMPv6Type
icmpv6TypeFromStringNum s = case s of
    "0" -> ICMPv6Type0Reserved
    "1" -> ICMPv6Type1DestinationUnreachable
    "2" -> ICMPv6Type2PacketTooBig
    "3" -> ICMPv6Type3TimeExceeded
    "4" -> ICMPv6Type4ParameterProblem
    "100" -> ICMPv6Type100PrivateExperimentation
    "101" -> ICMPv6Type101PrivateExperimentation
    "127" -> ICMPv6Type127ReservedForExpansionOfIcmpv6ErrorMessages
    "128" -> ICMPv6Type128EchoRequest
    "129" -> ICMPv6Type129EchoReply
    "130" -> ICMPv6Type130MulticastListenerQuery
    "131" -> ICMPv6Type131MulticastListenerReport
    "132" -> ICMPv6Type132MulticastListenerDone
    "133" -> ICMPv6Type133RouterSolicitation
    "134" -> ICMPv6Type134RouterAdvertisement
    "135" -> ICMPv6Type135NeighborSolicitation
    "136" -> ICMPv6Type136NeighborAdvertisement
    "137" -> ICMPv6Type137RedirectMessage
    "138" -> ICMPv6Type138RouterRenumbering
    "139" -> ICMPv6Type139IcmpNodeInformationQuery
    "140" -> ICMPv6Type140IcmpNodeInformationResponse
    "141" -> ICMPv6Type141InverseNeighborDiscoverySolicitationMessage
    "142" -> ICMPv6Type142InverseNeighborDiscoveryAdvertisementMessage
    "143" -> ICMPv6Type143Version2MulticastListenerReport
    "144" -> ICMPv6Type144HomeAgentAddressDiscoveryRequestMessage
    "145" -> ICMPv6Type145HomeAgentAddressDiscoveryReplyMessage
    "146" -> ICMPv6Type146MobilePrefixSolicitation
    "147" -> ICMPv6Type147MobilePrefixAdvertisement
    "148" -> ICMPv6Type148CertificationPathSolicitationMessage
    "149" -> ICMPv6Type149CertificationPathAdvertisementMessage
    "150" -> ICMPv6Type150IcmpMessagesUtilizedByExperimentalMobilityProtocolsSuchAsSeamoby
    "151" -> ICMPv6Type151MulticastRouterAdvertisement
    "152" -> ICMPv6Type152MulticastRouterSolicitation
    "153" -> ICMPv6Type153MulticastRouterTermination
    "154" -> ICMPv6Type154Fmipv6Messages
    "155" -> ICMPv6Type155RplControlMessage
    "156" -> ICMPv6Type156Ilnpv6LocatorUpdateMessage
    "157" -> ICMPv6Type157DuplicateAddressRequest
    "158" -> ICMPv6Type158DuplicateAddressConfirmation
    "159" -> ICMPv6Type159MplControlMessage
    "160" -> ICMPv6Type160ExtendedEchoRequest
    "161" -> ICMPv6Type161ExtendedEchoReply
    "200" -> ICMPv6Type200PrivateExperimentation
    "201" -> ICMPv6Type201PrivateExperimentation
    "255" -> ICMPv6Type255ReservedForExpansionOfIcmpv6InformationalMessages
    _ -> ICMPv6TypeUnknown


-- | Turn an 'ICMPv6Type' into a 'ICMPv6TypeNum'.
--
-- @since 1.0.0.0
icmpv6TypeToNum :: ICMPv6Type -> ICMPv6TypeNum
icmpv6TypeToNum t = case t of
    ICMPv6Type0Reserved -> ICMPv6TypeNum 0
    ICMPv6Type1DestinationUnreachable -> ICMPv6TypeNum 1
    ICMPv6Type2PacketTooBig -> ICMPv6TypeNum 2
    ICMPv6Type3TimeExceeded -> ICMPv6TypeNum 3
    ICMPv6Type4ParameterProblem -> ICMPv6TypeNum 4
    ICMPv6Type100PrivateExperimentation -> ICMPv6TypeNum 100
    ICMPv6Type101PrivateExperimentation -> ICMPv6TypeNum 101
    ICMPv6Type127ReservedForExpansionOfIcmpv6ErrorMessages -> ICMPv6TypeNum 127
    ICMPv6Type128EchoRequest -> ICMPv6TypeNum 128
    ICMPv6Type129EchoReply -> ICMPv6TypeNum 129
    ICMPv6Type130MulticastListenerQuery -> ICMPv6TypeNum 130
    ICMPv6Type131MulticastListenerReport -> ICMPv6TypeNum 131
    ICMPv6Type132MulticastListenerDone -> ICMPv6TypeNum 132
    ICMPv6Type133RouterSolicitation -> ICMPv6TypeNum 133
    ICMPv6Type134RouterAdvertisement -> ICMPv6TypeNum 134
    ICMPv6Type135NeighborSolicitation -> ICMPv6TypeNum 135
    ICMPv6Type136NeighborAdvertisement -> ICMPv6TypeNum 136
    ICMPv6Type137RedirectMessage -> ICMPv6TypeNum 137
    ICMPv6Type138RouterRenumbering -> ICMPv6TypeNum 138
    ICMPv6Type139IcmpNodeInformationQuery -> ICMPv6TypeNum 139
    ICMPv6Type140IcmpNodeInformationResponse -> ICMPv6TypeNum 140
    ICMPv6Type141InverseNeighborDiscoverySolicitationMessage -> ICMPv6TypeNum 141
    ICMPv6Type142InverseNeighborDiscoveryAdvertisementMessage -> ICMPv6TypeNum 142
    ICMPv6Type143Version2MulticastListenerReport -> ICMPv6TypeNum 143
    ICMPv6Type144HomeAgentAddressDiscoveryRequestMessage -> ICMPv6TypeNum 144
    ICMPv6Type145HomeAgentAddressDiscoveryReplyMessage -> ICMPv6TypeNum 145
    ICMPv6Type146MobilePrefixSolicitation -> ICMPv6TypeNum 146
    ICMPv6Type147MobilePrefixAdvertisement -> ICMPv6TypeNum 147
    ICMPv6Type148CertificationPathSolicitationMessage -> ICMPv6TypeNum 148
    ICMPv6Type149CertificationPathAdvertisementMessage -> ICMPv6TypeNum 149
    ICMPv6Type150IcmpMessagesUtilizedByExperimentalMobilityProtocolsSuchAsSeamoby -> ICMPv6TypeNum 150
    ICMPv6Type151MulticastRouterAdvertisement -> ICMPv6TypeNum 151
    ICMPv6Type152MulticastRouterSolicitation -> ICMPv6TypeNum 152
    ICMPv6Type153MulticastRouterTermination -> ICMPv6TypeNum 153
    ICMPv6Type154Fmipv6Messages -> ICMPv6TypeNum 154
    ICMPv6Type155RplControlMessage -> ICMPv6TypeNum 155
    ICMPv6Type156Ilnpv6LocatorUpdateMessage -> ICMPv6TypeNum 156
    ICMPv6Type157DuplicateAddressRequest -> ICMPv6TypeNum 157
    ICMPv6Type158DuplicateAddressConfirmation -> ICMPv6TypeNum 158
    ICMPv6Type159MplControlMessage -> ICMPv6TypeNum 159
    ICMPv6Type160ExtendedEchoRequest -> ICMPv6TypeNum 160
    ICMPv6Type161ExtendedEchoReply -> ICMPv6TypeNum 161
    ICMPv6Type200PrivateExperimentation -> ICMPv6TypeNum 200
    ICMPv6Type201PrivateExperimentation -> ICMPv6TypeNum 201
    ICMPv6Type255ReservedForExpansionOfIcmpv6InformationalMessages -> ICMPv6TypeNum 255
    ICMPv6TypeUnknown -> ICMPv6TypeNum 0


-- | Test if an 'ICMPv6Type' has been deprecated.
--
-- @since 1.0.0.0
isICMPv6TypeDeprecated :: ICMPv6Type -> Bool
isICMPv6TypeDeprecated ty = case ty of
   ICMPv6Type0Reserved-> False
   ICMPv6Type1DestinationUnreachable-> False
   ICMPv6Type2PacketTooBig-> False
   ICMPv6Type3TimeExceeded-> False
   ICMPv6Type4ParameterProblem-> False
   ICMPv6Type100PrivateExperimentation-> False
   ICMPv6Type101PrivateExperimentation-> False
   ICMPv6Type127ReservedForExpansionOfIcmpv6ErrorMessages-> False
   ICMPv6Type128EchoRequest-> False
   ICMPv6Type129EchoReply-> False
   ICMPv6Type130MulticastListenerQuery-> False
   ICMPv6Type131MulticastListenerReport-> False
   ICMPv6Type132MulticastListenerDone-> False
   ICMPv6Type133RouterSolicitation-> False
   ICMPv6Type134RouterAdvertisement-> False
   ICMPv6Type135NeighborSolicitation-> False
   ICMPv6Type136NeighborAdvertisement-> False
   ICMPv6Type137RedirectMessage-> False
   ICMPv6Type138RouterRenumbering-> False
   ICMPv6Type139IcmpNodeInformationQuery-> False
   ICMPv6Type140IcmpNodeInformationResponse-> False
   ICMPv6Type141InverseNeighborDiscoverySolicitationMessage-> False
   ICMPv6Type142InverseNeighborDiscoveryAdvertisementMessage-> False
   ICMPv6Type143Version2MulticastListenerReport-> False
   ICMPv6Type144HomeAgentAddressDiscoveryRequestMessage-> False
   ICMPv6Type145HomeAgentAddressDiscoveryReplyMessage-> False
   ICMPv6Type146MobilePrefixSolicitation-> False
   ICMPv6Type147MobilePrefixAdvertisement-> False
   ICMPv6Type148CertificationPathSolicitationMessage-> False
   ICMPv6Type149CertificationPathAdvertisementMessage-> False
   ICMPv6Type150IcmpMessagesUtilizedByExperimentalMobilityProtocolsSuchAsSeamoby-> False
   ICMPv6Type151MulticastRouterAdvertisement-> False
   ICMPv6Type152MulticastRouterSolicitation-> False
   ICMPv6Type153MulticastRouterTermination-> False
   ICMPv6Type154Fmipv6Messages-> False
   ICMPv6Type155RplControlMessage-> False
   ICMPv6Type156Ilnpv6LocatorUpdateMessage-> False
   ICMPv6Type157DuplicateAddressRequest-> False
   ICMPv6Type158DuplicateAddressConfirmation-> False
   ICMPv6Type159MplControlMessage-> False
   ICMPv6Type160ExtendedEchoRequest-> False
   ICMPv6Type161ExtendedEchoReply-> False
   ICMPv6Type200PrivateExperimentation-> False
   ICMPv6Type201PrivateExperimentation-> False
   ICMPv6Type255ReservedForExpansionOfIcmpv6InformationalMessages-> False
   ICMPv6TypeUnknown -> False