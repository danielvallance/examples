import express from 'express';
import { Webhooks, createNodeMiddleware } from "@octokit/webhooks";

const app = express();
const PORT = process.env.PORT || 3000;

// Webhooks secret handler
const webhooks = new Webhooks({
    secret: process.env.GITHUB_WEBHOOK_SECRET || undefined,
});

// Octokit middleware
// If you want to add the express json middleware, check this out https://github.com/octokit/webhooks.js/issues/1081
app.use(createNodeMiddleware(webhooks, { path: '/webhook/github' }));

// Helper function to log webhooks
const logWebhook = (event, data) => {
    const timestamp = new Date().toISOString();
    const logEntry = {
        timestamp,
        event,
        data,
        receivedAt: new Date().getTime()
    };

    // Log to console
    console.log(`[${timestamp}] Webhook received:`, event);
    console.log(JSON.stringify(logEntry, null, 2));

    return logEntry;
};

// Health check endpoint
app.get('/health', (req, res) => {
    res.status(200).json({
        status: 'healthy',
        timestamp: new Date().toISOString(),
        uptime: process.uptime()
    });
});

// GitHub webhook event handler
webhooks.onAny(({ id, name, payload }) => {
    logWebhook(name, payload);
});

webhooks.onError((error) => {
    console.error(`Error processing webhook: ${error.message}`);
});

// Start server
app.listen(PORT, () => { });
