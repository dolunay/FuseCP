// Copyright (C) 2025 FuseCP
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

namespace FuseCP.Providers.HeliconZoo
{
    public interface IHeliconZooServer
    {
    }

    public class HeliconZooEnv
    {
        public string Name { get; set; }
        public string Value { get; set; }
    }

    public class HeliconZooEngine
    {
        public string displayName { get; set; }
        public string name { get; set; }
        public string host { get; set; }
        public string protocol { get; set; }
        public string transport { get; set; }
        public string fullPath { get; set; }
        public string arguments { get; set; }
        public long minInstances { get; set; }
        public long maxInstances { get; set; }
        public long memoryLimit { get; set; }
        public long timeLimit { get; set; }
        public long gracefulShutdownTimeout { get; set; }
        public long portLower { get; set; }
        public long portUpper { get; set; }
        public bool disabled { get; set; }
        public bool isUserEngine { get; set; }
        public HeliconZooEnv[] environmentVariables { get; set; }
    }
}
