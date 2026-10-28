---
name: systematic-debugging
description: >
  Use when diagnosing test or build failures, runtime errors, regressions,
  flaky tests, performance anomalies, integration failures, or other
  unexpected technical behaviour. Establishes reproducible evidence, isolates
  the failure, tests one hypothesis at a time, fixes the root cause, and
  verifies the result. Do not use for implementing a known change, ordinary
  code review without a failure, or purely explanatory questions.
license: MIT; see LICENSE.md
---

# Systematic Debugging

Find the cause before committing to a fix.
Scale the investigation to the problem: a precise error with an obvious local cause needs less ceremony than an intermittent distributed failure, but both need evidence.

## Safety

- Preserve logs, failing inputs, and relevant state before changing the system.
- Do not expose secrets or personal data in diagnostics.
- Prefer read-only inspection and the smallest safe reproduction.
- Obtain approval before destructive commands, production changes, broad instrumentation, or access to sensitive systems.
- Separate temporary mitigation from a root-cause fix and record any follow-up work.

## 1. Define the Failure

1. State expected and actual behaviour in observable terms.
2. Capture the complete error, stack trace, failing command, environment, and relevant versions.
3. Reproduce the failure with the smallest reliable sequence.
4. Check whether it is deterministic, intermittent, environment-specific, or data-specific.
5. Inspect recent code, dependency, configuration, infrastructure, and environment changes.

If the failure cannot be reproduced, improve observation or request the missing evidence instead of guessing.

## 2. Localise the Cause

- Trace invalid data and state backwards from the symptom to where they originated.
- At component boundaries, compare inputs, outputs, configuration, and state to find the first divergence.
- Compare the failing path with a similar working path in the same system.
- Reduce the input, test scope, or component set while preserving the failure.
- Distinguish correlation from cause; recent changes are candidates, not verdicts.

Add temporary diagnostics only where existing evidence cannot distinguish between plausible causes.
Make diagnostics easy to remove and ensure they do not leak sensitive values.

For flaky asynchronous behaviour, wait for an observable condition rather than adding an arbitrary delay.
Use a bounded timeout with a useful failure message; retain fixed delays only when timing itself is under test.

## 3. Test a Hypothesis

State one falsifiable hypothesis:

> The failure occurs because **X**, supported by **Y**. If this is correct, **Z** will happen when tested.

Then:

1. Choose the smallest safe experiment that changes one variable.
2. Predict the result before running it.
3. Record whether the result supports or rejects the hypothesis.
4. Form a new hypothesis when rejected; do not stack speculative fixes.

After several failed hypotheses or attempted fixes, stop and revisit the reproduction, assumptions, and system boundaries.
If failures reveal pervasive coupling or shared state, discuss whether the architecture is the actual problem before trying another patch.

## 4. Implement the Fix

1. Add the smallest regression test or executable reproduction that fails for the confirmed cause, when feasible.
2. Change the source of the bad state or behaviour rather than merely suppressing its symptom.
3. Keep unrelated refactoring and opportunistic cleanup out of the fix.
4. Add validation or clearer errors at boundaries when they prevent recurrence or shorten future diagnosis.

In an incident, a reversible mitigation may come first when it reduces harm.
Preserve evidence, label the mitigation as temporary, and continue root-cause work afterwards.

## 5. Verify and Report

Verify with fresh evidence:

- The original reproduction no longer fails.
- The regression test fails without the fix and passes with it, where practical.
- Relevant focused and broader test suites pass.
- Flaky failures remain absent across repeated runs under the conditions that previously exposed them.
- Performance results improve against a controlled baseline under equivalent load and environment.
- Logs and metrics show no new errors or material regressions.
- Temporary diagnostics, outputs, and fixtures are removed; durable regression tests remain.

If a root cause cannot be confirmed after reasonable investigation, stop with an explicit inconclusive result.
Document the evidence gathered, causes ruled out, remaining hypotheses, and the observation needed to continue.
Use defensive handling or monitoring only when justified by the evidence, and do not present a mitigation as a fix.

Report:

1. Symptom and impact.
2. Reproduction and evidence.
3. Confirmed root cause, or an explicit inconclusive status.
4. Fix and why it addresses that cause.
5. Verification performed and results.
6. Anything not verified, residual risk, and follow-up work.

Do not claim that an issue is fixed when verification was unavailable or inconclusive.
