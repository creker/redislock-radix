# redislock

[![Build Status](https://travis-ci.org/creker/redislock-radix.png?branch=master)](https://travis-ci.org/creker/redislock-radix)
[![GoDoc](https://godoc.org/github.com/creker/redislock-radix?status.png)](http://godoc.org/github.com/creker/redislock-radix)
[![Go Report Card](https://goreportcard.com/badge/github.com/creker/redislock-radix)](https://goreportcard.com/report/github.com/creker/redislock-radix)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

This is a fork of [https://github.com/bsm/redislock](https://github.com/bsm/redislock) that replaces go-redis with radix.

Simplified distributed locking implementation using [Redis](http://redis.io/topics/distlock).
For more information, please see examples.

## Examples

```go
import (
  "fmt"
  "time"

  "github.com/creker/redislock-radix"
  "github.com/mediocregopher/radix/v3"
)

func main() {
	// Connect to redis.
	client, err := radix.NewPool("tcp", "127.0.0.1:6379", 10)
	if err != nil {
		log.Fatalln(err)
	}
	defer client.Close()

	// Create a new lock client.
	locker := redislock.New(client)

	// Try to obtain lock.
	lock, err := locker.Obtain("my-key", 100*time.Millisecond, nil)
	if err == redislock.ErrNotObtained {
		fmt.Println("Could not obtain lock!")
	} else if err != nil {
		log.Fatalln(err)
	}

	// Don't forget to defer Release.
	defer lock.Release()
	fmt.Println("I have a lock!")

	// Sleep and check the remaining TTL.
	time.Sleep(50 * time.Millisecond)
	if ttl, err := lock.TTL(); err != nil {
		log.Fatalln(err)
	} else if ttl > 0 {
		fmt.Println("Yay, I still have my lock!")
	}

	// Extend my lock.
	if err := lock.Refresh(100*time.Millisecond, nil); err != nil {
		log.Fatalln(err)
	}

	// Sleep a little longer, then check.
	time.Sleep(100 * time.Millisecond)
	if ttl, err := lock.TTL(); err != nil {
		log.Fatalln(err)
	} else if ttl == 0 {
		fmt.Println("Now, my lock has expired!")
	}

}
```

## Documentation

Full documentation is available on [GoDoc](https://godoc.org/github.com/creker/redislock-radix)
