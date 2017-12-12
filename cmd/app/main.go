package main

import (
	"os"
	"os/signal"
	"syscall"

	"github.com/apex/log"
	"github.com/apex/log/handlers/cli"
)

func main() {
	// setup logger
	logger := &log.Logger{
		Handler: cli.Default,
		Level:   log.InfoLevel,
	}

	logger.Infof("Starting app")

	done := make(chan os.Signal, 1)
	signal.Notify(done, syscall.SIGINT, syscall.SIGTERM)

	// waiting OS signals to exit
	<-done

	logger.Info("Shouting down ...")
	logger.Info("Done")
}
