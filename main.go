// +build mytag

package main

import (
	"flag"
	"time"
)

func main() {
	m := flag.Int("multiplier", 1, "a multiplier")
	flag.Parse()

	c := 0
	for {
		time.Sleep(time.Second * 1)
		c++

		println(c * *m)
	}
}
