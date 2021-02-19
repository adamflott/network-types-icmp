// This was the easiest/fastest approach to parsing the ICMP XML spec and
// writing a template. Please forgive me Haskell community!

package main

import (
	"flag"
	"encoding/xml"
	"fmt"
	"strconv"
	"text/template"
	"os"
	"strings"
)

type Registry struct {
	XMLName  xml.Name `xml:"registry"`
	Text     string   `xml:",chardata"`
	Xmlns    string   `xml:"xmlns,attr"`
	ID       string   `xml:"id,attr"`
	Title    string   `xml:"title"`
	Updated  string   `xml:"updated"`
	Registry []struct {
		Text  string `xml:",chardata"`
		ID    string `xml:"id,attr"`
		Title string `xml:"title"`
		Xref  struct {
			Text string `xml:",chardata"`
			Type string `xml:"type,attr"`
			Data string `xml:"data,attr"`
		} `xml:"xref"`
		RegistrationRule string `xml:"registration_rule"`
		Note             string `xml:"note"`
		Record           []struct {
			Text        string `xml:",chardata"`
			Date        string `xml:"date,attr"`
			Value       string `xml:"value"`
			Description string `xml:"description"`
			Xref        []struct {
				Text string `xml:",chardata"`
				Type string `xml:"type,attr"`
				Data string `xml:"data,attr"`
			} `xml:"xref"`
		} `xml:"record"`
		Registry []struct {
			Text  string `xml:",chardata"`
			ID    string `xml:"id,attr"`
			Title struct {
				Text string `xml:",chardata"`
				Xref struct {
					Text string `xml:",chardata"`
					Type string `xml:"type,attr"`
					Data string `xml:"data,attr"`
				} `xml:"xref"`
			} `xml:"title"`
			Xref []struct {
				Text string `xml:",chardata"`
				Type string `xml:"type,attr"`
				Data string `xml:"data,attr"`
			} `xml:"xref"`
			RegistrationRule string `xml:"registration_rule"`
			Record           []struct {
				Text        string `xml:",chardata"`
				Date        string `xml:"date,attr"`
				Value       string `xml:"value"`
				Description string `xml:"description"`
				Xref        struct {
					Text string `xml:",chardata"`
					Type string `xml:"type,attr"`
					Data string `xml:"data,attr"`
				} `xml:"xref"`
			} `xml:"record"`
			Expert string `xml:"expert"`
		} `xml:"registry"`
		Footnote struct {
			Text   string `xml:",chardata"`
			Anchor string `xml:"anchor,attr"`
		} `xml:"footnote"`
		Range []struct {
			Text             string `xml:",chardata"`
			Value            string `xml:"value"`
			RegistrationRule string `xml:"registration_rule"`
		} `xml:"range"`
	} `xml:"registry"`
	People struct {
		Text   string `xml:",chardata"`
		Person []struct {
			Text    string `xml:",chardata"`
			ID      string `xml:"id,attr"`
			Name    string `xml:"name"`
			URI     string `xml:"uri"`
			Updated string `xml:"updated"`
		} `xml:"person"`
	} `xml:"people"`
}

type RegistryV6 struct {
	XMLName  xml.Name `xml:"registry"`
	Text     string   `xml:",chardata"`
	Xmlns    string   `xml:"xmlns,attr"`
	ID       string   `xml:"id,attr"`
	Title    string   `xml:"title"`
	Updated  string   `xml:"updated"`
	Registry []struct {
		Text  string `xml:",chardata"`
		ID    string `xml:"id,attr"`
		Title string `xml:"title"`
		Xref  []struct {
			Text string `xml:",chardata"`
			Type string `xml:"type,attr"`
			Data string `xml:"data,attr"`
		} `xml:"xref"`
		Range []struct {
			Text             string `xml:",chardata"`
			Value            string `xml:"value"`
			RegistrationRule string `xml:"registration_rule"`
		} `xml:"range"`
		Record []struct {
			Text    string `xml:",chardata"`
			Date    string `xml:"date,attr"`
			Updated string `xml:"updated,attr"`
			Value   string `xml:"value"`
			Name    string `xml:"name"`
			Xref    []struct {
				Text string `xml:",chardata"`
				Type string `xml:"type,attr"`
				Data string `xml:"data,attr"`
			} `xml:"xref"`
			Description struct {
				Text string `xml:",chardata"`
				Xref struct {
					Text string `xml:",chardata"`
					Type string `xml:"type,attr"`
					Data string `xml:"data,attr"`
				} `xml:"xref"`
			} `xml:"description"`
			Elliptic struct {
				Text string `xml:",chardata"`
				Xref struct {
					Text string `xml:",chardata"`
					Type string `xml:"type,attr"`
					Data string `xml:"data,attr"`
				} `xml:"xref"`
			} `xml:"elliptic"`
			Hash struct {
				Text string `xml:",chardata"`
				Xref struct {
					Text string `xml:",chardata"`
					Type string `xml:"type,attr"`
					Data string `xml:"data,attr"`
				} `xml:"xref"`
			} `xml:"hash"`
			Signature struct {
				Text string `xml:",chardata"`
				Xref struct {
					Text string `xml:",chardata"`
					Type string `xml:"type,attr"`
					Data string `xml:"data,attr"`
				} `xml:"xref"`
			} `xml:"signature"`
			RepConv struct {
				Text string `xml:",chardata"`
				Xref struct {
					Text string `xml:",chardata"`
					Type string `xml:"type,attr"`
					Data string `xml:"data,attr"`
				} `xml:"xref"`
			} `xml:"rep_conv"`
			PublicKeySize string `xml:"public_key_size"`
			SignatureSize string `xml:"signature_size"`
		} `xml:"record"`
		Registry []struct {
			Text  string `xml:",chardata"`
			ID    string `xml:"id,attr"`
			Title string `xml:"title"`
			Xref  struct {
				Text string `xml:",chardata"`
				Type string `xml:"type,attr"`
				Data string `xml:"data,attr"`
			} `xml:"xref"`
			RegistrationRule string `xml:"registration_rule"`
			Record           []struct {
				Text  string `xml:",chardata"`
				Date  string `xml:"date,attr"`
				Value string `xml:"value"`
				Name  string `xml:"name"`
				Xref  []struct {
					Text string `xml:",chardata"`
					Type string `xml:"type,attr"`
					Data string `xml:"data,attr"`
				} `xml:"xref"`
			} `xml:"record"`
			Expert string `xml:"expert"`
		} `xml:"registry"`
		RegistrationRule string `xml:"registration_rule"`
		Note             struct {
			Text string `xml:",chardata"`
			Xref struct {
				Text string `xml:",chardata"`
				Type string `xml:"type,attr"`
				Data string `xml:"data,attr"`
			} `xml:"xref"`
		} `xml:"note"`
		Footnote struct {
			Text   string `xml:",chardata"`
			Anchor string `xml:"anchor,attr"`
			Xref   struct {
				Text string `xml:",chardata"`
				Type string `xml:"type,attr"`
				Data string `xml:"data,attr"`
			} `xml:"xref"`
		} `xml:"footnote"`
		Expert string `xml:"expert"`
	} `xml:"registry"`
	People string `xml:"people"`
}

type Type uint16

type Codes struct {
	TypeName string
	TypeCode uint8
	Description string
	IsDeprecated bool
	IsUnassigned bool
	TCodes []*Code
}

type Code struct {
	Name  string
	Value uint8
	IsUnassigned bool
}

type TmplVars struct {
	FourOrSix string
	Updated string
	M map[Type]*Codes
}

func main() {
	four_or_six := false
	flag.BoolVar(&four_or_six, "use-v6", four_or_six, "Toggle from ICMP to ICMPv6")
	flag.Parse()

	m := make(map[Type]*Codes)

	tmpl_vars := TmplVars{
		Updated : "?",
	}

	if four_or_six {

		var r RegistryV6
		d := xml.NewDecoder(os.Stdin)

		err := d.Decode(&r)
		if err != nil {
			fmt.Println(err)
		}

		tmpl_vars.Updated = r.Updated

		// -- ICMPv6 ------------------------------------------------------------
		for _, v := range r.Registry {
			if v.ID == "icmpv6-parameters-2" || v.ID == "icmpv6-parameters-3" {
				fmt.Printf("registry id: %s\n", v.ID)
				for _, record := range v.Record {

					start := Type(0)
					end := Type(0)

					val_str := strings.Split(record.Value, "-")

					switch len(val_str) {
					case 0:
						panic("val_str len is 0")
					case 1: {
						n, pe := strconv.ParseUint(val_str[0], 10, 8)
						if pe != nil {
							panic(pe)
						}
						start = Type(n)
						end = start
					}
					case 2: {
						n, pe := strconv.ParseUint(val_str[0], 10, 8)
						if pe != nil {
							panic(pe)
						}

						n2, pe2 := strconv.ParseUint(val_str[1], 10, 8)
						if pe2 != nil {
							panic(pe2)
						}
						start = Type(n)
						end = Type(n2)
					}
					}

					if start == Type(255) {
						fmt.Println("before for", start, end, end+1)
					}

					for i := start; i < end + 1; i++ {
						if start == Type(255) {
							fmt.Println("in for", start, end)
						}

						if _, ok := m[Type(i)]; !ok {

							s := strings.ReplaceAll(record.Name, "\n", " ")
							s = strings.Title(strings.ToLower(s))
							s = strings.ReplaceAll(s, " ", "")
							s = "ICMPv6Type" + strconv.FormatUint(uint64(i), 10) + s

							desc := record.Name
							desc = strings.ReplaceAll(desc, "\n", " ")
							desc = strings.TrimSpace(desc)
							if desc == "" {
								desc = "N/A - No description in spec"
							}

							isUnassigned := false
							if strings.Contains(desc, "Unassigned") {
								isUnassigned = true
							}
							m[Type(i)] = &Codes{TypeName: s, TypeCode: uint8(i), IsDeprecated: false, IsUnassigned : isUnassigned, Description: desc, TCodes: make([]*Code, 0)}
						}
					}
				}


				for _, reg := range v.Registry {
					t := strings.ReplaceAll(reg.Title, " ", "")
					split_pos := strings.Index(t, "-")
					type_code_str := t[len("Type"): split_pos]
					type_code_64, _ := strconv.ParseUint(type_code_str, 10, 8)
					type_code_n := Type(type_code_64)

					fmt.Printf("Title=%s rec count=%d\n", reg.Title, len(reg.Record))

					for _, rec := range reg.Record {

						start := uint(0)
						end := uint(0)

						val_str := strings.Split(rec.Value, "-")

						switch len(val_str) {
						case 0:
							panic("val_str len is 0")
						case 1: {
							n, pe := strconv.ParseUint(val_str[0], 10, 8)
							if pe != nil {
								panic(pe)
							}
							start = uint(n)
							end = start
						}
						case 2: {
							n, pe := strconv.ParseUint(val_str[0], 10, 8)
							if pe != nil {
								panic(pe)
							}

							n2, pe2 := strconv.ParseUint(val_str[1], 10, 8)
							if pe2 != nil {
								panic(pe2)
							}
							start = uint(n)
							end = uint(n2)
						}
						}

						for i := start; i <= end; i++ {
							if v, ok := m[type_code_n]; ok {
								isUnassigned := false
								if strings.Contains(rec.Name, "Unassigned") {
									isUnassigned = true
								}

								name := strings.TrimSpace(rec.Name)
								if name == "" {
									name = "N/A - No description in spec"
								}

								v.TCodes = append(v.TCodes, &Code{
									Name : name,
									Value : uint8(i),
									IsUnassigned :isUnassigned,
								})
							} else {
								fmt.Println(i, "not found")
							}
						}
					}
				}
			}
		}
	} else {
		// -- ICMP ------------------------------------------------------------


		var r Registry
		d := xml.NewDecoder(os.Stdin)

		err := d.Decode(&r)
		if err != nil {
			fmt.Println(err)
		}

		tmpl_vars.Updated = r.Updated

		for _, v := range r.Registry {

			if v.ID == "icmp-parameters-types" {
				for _, record := range v.Record {
					desc := strings.ReplaceAll(record.Description, "\n", " ")

					isDeprecated := false
					if strings.Contains(desc, "(Deprecated)") {
						isDeprecated = true
					}

					start := Type(0)
					end := Type(0)

					val_str := strings.Split(record.Value, "-")

					switch len(val_str) {
					case 0:
						panic("val_str len is 0")
					case 1: {
						n, pe := strconv.ParseUint(val_str[0], 10, 8)
						if pe != nil {
							panic(pe)
						}
						start = Type(n)
						end = start + 1
					}
					case 2: {
						n, pe := strconv.ParseUint(val_str[0], 10, 8)
						if pe != nil {
							panic(pe)
						}

						n2, pe2 := strconv.ParseUint(val_str[1], 10, 8)
						if pe2 != nil {
							panic(pe2)
						}
						start = Type(n)
						end = Type(n2)
					}
					}

					for i := start; i < end; i++ {
						s := strings.ReplaceAll(record.Description, "\n", " ")


						isUnassigned := false
						if strings.Contains(s, "Unassigned") {
							isUnassigned = true
						}

						s = strings.ReplaceAll(s, "-", "")
						s = strings.Title(strings.ToLower(s))
						s = strings.ReplaceAll(s, " ", "")

						s = strings.ReplaceAll(s, "(", "")
						s = strings.ReplaceAll(s, ")", "")

						s = "ICMPType" +  strconv.FormatUint(uint64(i), 10) + s


						if _, ok := m[Type(i)]; !ok {

							m[Type(i)] = &Codes{TypeName: s, TypeCode: uint8(i), IsDeprecated: isDeprecated, IsUnassigned : isUnassigned, Description: desc, TCodes: make([]*Code, 0)}
						}
					}
				}
			}

			if v.ID == "icmp-parameters-codes" {
				for _, reg := range v.Registry {
					for _, rec := range reg.Record {
						//fmt.Println(reg.ID, reg.Title, rec.Value, rec.Description)

						t := strings.ReplaceAll(reg.Title.Text, " ", "")

						delim := "—"
						if four_or_six {
							delim = "-"
						}

						split_pos := strings.Index(t, delim)
						//fmt.Println("split_pos", split_pos)
						type_code_str := t[len("Type"): split_pos]
						//fmt.Println(type_code_str)
						type_code_64, pe := strconv.ParseUint(type_code_str, 10, 8)
						if pe != nil {
							panic(pe)
						}
						type_code_n := Type(type_code_64)

						//						fmt.Println(type_code_str, rec)
						if v, ok := m[type_code_n]; ok {

							code, _ := strconv.ParseUint(rec.Value, 10, 8)

							desc := strings.ReplaceAll(rec.Description, "\n", " ")

							isUnassigned := false
							if strings.Contains(desc, "Unassigned") {
								isUnassigned = true
							}

							v.TCodes = append(v.TCodes, &Code{
								Name : desc,
								Value : uint8(code),
								IsUnassigned : isUnassigned,
							})

						} else {
							fmt.Println(type_code_n, "v4 not found")
						}
					}
				}
			}
		}
	}

	for k, v := range m {
		fmt.Printf("Type: %d\n", k)
		fmt.Printf("Type Name: '%s'\n", v.TypeName)
		for _, c := range v.TCodes {
			fmt.Printf("\tName: '%s' Code: %d\n", c.Name, c.Value)
		}
	}

	tmpl_file := ""
	out_file := ""
	v_type := ""
	if four_or_six {
		tmpl_file = "./templates/icmpv6.tmpl"
		out_file = "src/Network/Types/ICMPv6.hs"
		v_type = "v6"
	} else {
		tmpl_file = "./templates/icmpv6.tmpl"
		out_file = "src/Network/Types/ICMP.hs"
		v_type = ""
	}

	// Create a new template and parse the letter into it.
	t, parse_err := template.ParseFiles(tmpl_file)
	if parse_err != nil {
		fmt.Println("parse file: ", parse_err)
		os.Exit(1)
	}

	fh, create_err := os.Create(out_file)
	if create_err != nil {
		fmt.Println("create file: ", create_err)
		os.Exit(2)
	}

	vars := TmplVars{
		FourOrSix : v_type,
		M : m,
		Updated: tmpl_vars.Updated,
	}

	tmpl_err := t.Execute(fh, vars)
	if tmpl_err != nil {
		fmt.Print("execute: ", tmpl_err)
		os.Exit(3)
	}
}
